//
//  PNEArcView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEArcView.h"
#import "PNEView.h"

@implementation PNEArcView

#pragma mark - Lifecycle

- (id) initWithValues: (PNArcInscription*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view]) 
    {   isInhibitor = [pnElement flowFunction] == INHIBITOR;
        [superView.arcs addObject:self];
        weight = [pnElement flowFunction];
        touchViews = [[NSMutableArray alloc] init];
                
        options = [[UIActionSheet alloc] initWithTitle:@"Options:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Convert", @"Change weight", nil];
    }
    return self;
}

- (void) dealloc {
    [superView.arcs removeObject:self];
    [touchViews dealloc];
    [super dealloc];
}

#pragma mark - Touch logic

- (void) handleLongGesture: (UILongPressGestureRecognizer *) gesture {
    [options showFromRect:gesture.view.bounds inView:gesture.view animated:true];
}

- (void) createTouchZone {
    //Release all touch views of the previous cycle
    [self removeTouchZone];
    
    CGFloat xDistance = MAX(startPoint.x, endPoint.x) - MIN(startPoint.x, endPoint.x);
    CGFloat yDistance = MAX(startPoint.y, endPoint.y) - MIN(startPoint.y, endPoint.y);
    
    //The amount of touchviews depends on the horizontal distance
    CGFloat zones =  MAX(round(xDistance / ARC_TOUCH_BASE), 1);
    CGFloat zoneWidth = xDistance / zones;
    CGFloat zoneHeight = yDistance / zones;
    
    //Ensure that each touch zone has the minimum dimensions
    CGFloat actualWidth = (zoneWidth > ARC_TOUCH_MIN) ? zoneWidth : ARC_TOUCH_MIN;
    CGFloat actualHeight = (zoneHeight > ARC_TOUCH_MIN) ? zoneHeight : ARC_TOUCH_MIN;
    
    for (int ctr = 0; ctr < zones; ctr ++) {
        CGRect rect = CGRectMake(0, 0, actualWidth, actualHeight);
        rect.origin.x = MIN(startPoint.x, endPoint.x) + ctr * zoneWidth;
        
        if ((startPoint.x < endPoint.x && startPoint.y < endPoint.y) ||
            (startPoint.x > endPoint.x && startPoint.y > endPoint.y)) 
            rect.origin.y = (MIN(startPoint.y, endPoint.y) + ctr * zoneHeight);
        else rect.origin.y = (MAX(startPoint.y, endPoint.y) - (ctr + 1) * zoneHeight);
        
        UIView *touchZone = [[UIView alloc] initWithFrame:rect];        
        UILongPressGestureRecognizer *hold = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
        [touchZone addGestureRecognizer:hold];
                
        [superView addSubview:touchZone];
        [touchViews addObject:touchZone];
    }
}

- (void) removeTouchZone {
    for (UIView *view in touchViews) {
        [view removeFromSuperview];
    }
    [touchViews removeAllObjects];
}

- (void) updateTouchZone {
    [self createTouchZone];
}

- (void) addTouchResponder:(UIGestureRecognizer *)recognizer {
    NSLog(@"addTouchResponder (PNEArcView) called. recognizers can only belong to one view, recognizers must be added manually in createTouchZone instead");
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        if ([fromNode class] == [PNETransitionView class])
            [fromNode.element removeOutput:toNode.element];
        
        //Niet in else steken, expliciet laten checken 
        else [toNode.element removeInput:fromNode.element];
        [superView loadKernel];
        [element release];
    }
    
    //TODO: fix this to use the add of transitions to check if inhibitor is allowed
    else {
        isInhibitor = !isInhibitor;
        [element setType: isInhibitor ? NORMAL:INHIBITOR];
        [superView setNeedsDisplay];
    }
}


#pragma mark - Help functions

- (void) setNodes: (PNENodeView*) newFromNode toNode: (PNENodeView*) newToNode {
    fromNode = newFromNode;
    toNode = newToNode;
    
    if ([toNode class] == [PNEPlaceView class])
        [toNode addNeighbour: fromNode isInput: false];
    else [fromNode addNeighbour: toNode isInput: true];
}


#pragma mark - Drawing code

//Draws the end of a normal arc
- (void) drawArrow: (CGPoint) arrowStart arrowEnd: (CGPoint) arrowEnd {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    //The angle of the start of the back line of the arrow with the x-axis
    CGFloat startAngle;
    
    //Calculate the x and y distances between the start and endpoint
    CGFloat xDistance = MAX(arrowStart.x, arrowEnd.x) - MIN(arrowStart.x, arrowEnd.x);
    CGFloat yDistance = MAX(arrowStart.y, arrowEnd.y) - MIN(arrowStart.y, arrowEnd.y);
    
    //Calculate the angle
    if (arrowStart.y < arrowEnd.y && arrowStart.x < arrowEnd.x)
        startAngle = M_PI_2 + atan(yDistance/xDistance);
    if (arrowStart.y < arrowEnd.y && arrowStart.x > arrowEnd.x) 
        startAngle = M_PI_2 - atan(yDistance/xDistance);
    if (arrowStart.y > arrowEnd.y && arrowStart.x > arrowEnd.x)
        startAngle = atan(yDistance/xDistance) + M_PI_2;
    if (arrowStart.y > arrowEnd.y && arrowStart.x < arrowEnd.x) 
        startAngle = M_PI_2 - atan(yDistance/xDistance);
    
    
    //Create the arrow
    CGContextMoveToPoint(context, arrowStart.x, arrowStart.y);
    CGContextAddArc(context, arrowStart.x, arrowStart.y, ARC_END_SIZE / 2, startAngle, startAngle, 1);
    CGContextAddLineToPoint(context, arrowEnd.x, arrowEnd.y);
    CGContextMoveToPoint(context, arrowStart.x, arrowStart.y);
    CGContextAddArc(context, arrowStart.x, arrowStart.y, ARC_END_SIZE / 2 , startAngle + M_PI, startAngle + M_PI, 1);
    CGContextAddLineToPoint(context, arrowEnd.x, arrowEnd.y);

    //Fill the arrow
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillPath(context);    
}

//Draws the end of an inhibitor arc
- (void) drawCircle: (CGPoint) circleStart circleEnd: (CGPoint) circleEnd {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    //Calculate the centre of the circle
    CGPoint midPoint;
    
    midPoint.x = MIN(circleStart.x, circleEnd.x) + (MAX(circleStart.x, circleEnd.x) - MIN(circleStart.x, circleEnd.x)) / 2;
    midPoint.y = MIN(circleStart.y, circleEnd.y) + (MAX(circleStart.y, circleEnd.y) - MIN(circleStart.y, circleEnd.y)) / 2;
        
    //Create the circle
    CGContextAddArc(context, midPoint.x, midPoint.y, ARC_END_SIZE / 2, 0, M_PI * 2, 0);
    
    //Draw the circle
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);
}

//We draw an arc in 3 steps
//First, we calculate the point where the line ends and the arrow/circle begins
//Then we draw a line between the startpoint and this point
//Lastly we call another function to draw the arrow/circle
- (void) draw {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Create the triangle startPoint, endPoint, Se. Where SE has the X-value of startPoint and the Y-value of endPoint
    CGPoint SE = CGPointMake(startPoint.x, endPoint.y);
    
    //Calculate the lengths of some sides in this triangle
    CGFloat SeAngleOpposite;
    CGFloat SeAngleAdjacent;
    if ((SeAngleOpposite = startPoint.y - SE.y) < 0)
        SeAngleOpposite = SE.y - startPoint.y;
    if ((SeAngleAdjacent = startPoint.x - endPoint.x) < 0)
        SeAngleAdjacent = endPoint.x - startPoint.x;
    
    //Calculate the angle of Se 
    CGFloat SeAngle = atan(SeAngleOpposite / SeAngleAdjacent);
    
    //Calculate the distance from the tonode attachement point to the line end point
    CGFloat lineEndXdistance = ARC_END_SIZE * cos(SeAngle);
    CGFloat lineEndYdistance = ARC_END_SIZE * sin(SeAngle);
    CGPoint lineEnd;
    
    //Calculate the point where the line ends 
    if ([fromNode isRight:toNode])
        lineEnd.x = endPoint.x - lineEndXdistance;
    else lineEnd.x = endPoint.x + lineEndXdistance;
    
    if ([fromNode isLower:toNode])
        lineEnd.y = endPoint.y - lineEndYdistance;
    else lineEnd.y = endPoint.y + lineEndYdistance;
        
    //Draw the Line
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, lineEnd.x, lineEnd.y);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);
    
    //Draw the arrow/circle
    if (isInhibitor)
        [self drawCircle:lineEnd circleEnd:endPoint];
    else [self drawArrow:lineEnd arrowEnd:endPoint];
    
    }

//Draws the weight of an arc
- (void) drawWeight {
    if (!superView.showLabels || (weight == 0 && isInhibitor) || weight == 1)
        return;
    
    //Prepare the text
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSelectFont(context, MAIN_FONT_NAME, MAIN_FONT_SIZE, kCGEncodingMacRoman);
    
    //Prepare the string
    NSString *weightString = [NSString stringWithFormat:@"%d", weight];
    NSUInteger textLength = [weightString length];
    const char *weightText = [weightString cStringUsingEncoding: [NSString defaultCStringEncoding]];
    
    //Inverse the text to makeup for the difference between the uikit and core graphics coordinate systems
    CGAffineTransform flip = CGAffineTransformMakeScale(1, -1);
    CGContextSetTextMatrix(context, flip);
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGFloat xVal = MIN(startPoint.x, endPoint.x) + (MAX(startPoint.x, endPoint.x) - MIN(startPoint.x, endPoint.x)) / 2;
    CGFloat yVal = MIN(startPoint.y, endPoint.y) + (MAX(startPoint.y, endPoint.y) - MIN(startPoint.y, endPoint.y)) / 2;
    
    CGContextShowTextAtPoint(context, xVal + LABEL_DISTANCE , yVal - LABEL_DISTANCE  , weightText, textLength);
}

//Calculates the start and end points of the arc
- (void) calculateAttachmentPoints {
    if ([fromNode isLeft:toNode]) {
        startPoint = [fromNode getLeftEdge];
        endPoint = [toNode getRightEdge];
    }
    if ([fromNode isRight:toNode]) {
        startPoint = [fromNode getRightEdge];
        endPoint = [toNode getLeftEdge];
    }
    if ([fromNode isLower:toNode]) {
        startPoint = [fromNode getBottomEdge]; 
        endPoint = [toNode getTopEdge];
    }
    if ([fromNode isHigher:toNode]) {
        startPoint = [fromNode getTopEdge];
        endPoint = [toNode getBottomEdge];
    }
    
    if ([fromNode isLeftAndHigher:toNode]) {
        startPoint = [fromNode getLeftTopPoint];
        endPoint = [toNode getRightBottomPoint];
    }
    if ([fromNode isLeftAndLower:toNode]) {
        startPoint = [fromNode getLeftBottomPoint]; 
        endPoint = [toNode getRightTopPoint];
    }
    if ([fromNode isRightAndHigher:toNode]) {
        startPoint = [fromNode getRightTopPoint];
        endPoint = [toNode getLeftBottomPoint];
    }
    if ([fromNode isRightAndLower:toNode]) {
        startPoint = [fromNode getRightBottomPoint];
        endPoint = [toNode getLeftTopPoint];
    }
}

//Calls the appropriate arc drawing functions
- (void) drawArc {
    CGPoint prevStart = startPoint;
    CGPoint prevEnd = endPoint;
    
    [self calculateAttachmentPoints];
    [self drawWeight];
    
    [self draw];
    
    //Only create new touch zones when the arc moved
    if (prevStart.x != startPoint.x || prevStart.y != startPoint.y ||
        prevEnd.x != endPoint.x || prevEnd.y != endPoint.y)
        [self createTouchZone];
}

@end
