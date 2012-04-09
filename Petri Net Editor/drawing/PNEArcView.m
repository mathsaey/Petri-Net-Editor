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

- (id) initWithValues: (PNArcInscription*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view]) 
    {   isInhibitor = [pnElement flowFunction] == INHIBITOR;
        isMarked = false;
        [superView.arcs addObject:self];}
    return self;
}

- (void) setNodes: (PNENodeView*) newFromNode toNode: (PNENodeView*) newToNode {
    fromNode = newFromNode;
    toNode = newToNode;
}

- (void) toggleHighlight {
    isMarked = !isMarked;
    [superView setNeedsDisplay]; //TODO: make this only change the highlightrect
}

- (void) drawArrow: (CGPoint) startPoint endPoint: (CGPoint) endPoint {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    //The angle of the start of the back of the arrow with the x-axis
    CGFloat startAngle;
    
    CGFloat xDistance;
    CGFloat yDistance;
    
    //TODO: review this part
    
    //Calculate the x and y distances between the start and endpoint
    if (startPoint.x < endPoint.x)
        xDistance = endPoint.x - startPoint.x;
    else xDistance = startPoint.x - endPoint.x;
    
    if (startPoint.y < endPoint.y)
        yDistance = endPoint.y - startPoint.y;
    else yDistance = startPoint.y - endPoint.y;
    
    //Calculate the angle
    if (startPoint.y < endPoint.y && startPoint.x < endPoint.x)
        startAngle = M_PI_2 + atan(yDistance/xDistance);
    if (startPoint.y < endPoint.y && startPoint.x > endPoint.x) 
        startAngle = M_PI_2 - atan(yDistance/xDistance);
    if (startPoint.y > endPoint.y && startPoint.x > endPoint.x)
        startAngle = atan(yDistance/xDistance) + M_PI_2;
    if (startPoint.y > endPoint.y && startPoint.x < endPoint.x) 
        startAngle = M_PI_2 - atan(yDistance/xDistance);
    
    
    //Create the arrow
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddArc(context, startPoint.x, startPoint.y, ARC_END_SIZE / 2, startAngle, startAngle, 1);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddArc(context, startPoint.x, startPoint.y, ARC_END_SIZE / 2 , startAngle + M_PI, startAngle + M_PI, 1);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);

    //Fill the arrow
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillPath(context);    
}

- (void) drawCircle: (CGPoint) startPoint endPoint: (CGPoint) endPoint {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGPoint midPoint;
    
    //Calculate the midpoint of the circle
    if (startPoint.x < endPoint.x)
        midPoint.x = startPoint.x + (endPoint.x - startPoint.x) / 2;
    else midPoint.x = endPoint.x + (startPoint.x - endPoint.x) / 2;
    
    if (startPoint.y < endPoint.y)
        midPoint.y = startPoint.y + (endPoint.y - startPoint.y) / 2;
    else midPoint.y = endPoint.y + (startPoint.y - endPoint.y) /2;
        
    //Create the circle
    CGContextAddArc(context, midPoint.x, midPoint.y, ARC_END_SIZE / 2, 0, M_PI * 2, 0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);
}

//We draw an arc in 3 steps
//First, we calculate the point where the line ends and the arrow/circle begins
//Then we draw a line between the startpoint and this point
//Lastly we call another function to draw the arrow/circle
- (void) draw: (CGPoint) startPoint endPoint: (CGPoint) endPoint {
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
        [self drawCircle:lineEnd endPoint:endPoint];
    else [self drawArrow:lineEnd endPoint:endPoint];
    
    }

//Calculates the start and end points of the arc
- (void) calculateAttachmentPoints {
    if ([fromNode isLeftAndHigher:toNode])
        return [self draw:[fromNode getLeftTopPoint] endPoint:[toNode getRightBottomPoint]];
    if ([fromNode isLeftAndLower:toNode])
        return [self draw:[fromNode getLeftBottomPoint] endPoint:[toNode getRightTopPoint]];
    if ([fromNode isRightAndHigher:toNode])
        return [self draw:[fromNode getRightTopPoint] endPoint:[toNode getLeftBottomPoint]];
    if ([fromNode isRightAndLower:toNode])
        return [self draw:[fromNode getRightBottomPoint] endPoint:[toNode getLeftTopPoint]];
    
    
    if ([fromNode isLeft:toNode])
        return [self draw:[fromNode getLeftEdge] endPoint:[toNode getRightEdge]];
    if ([fromNode isRight:toNode])
        return [self draw:[fromNode getRightEdge] endPoint:[toNode getLeftEdge]];
    if ([fromNode isLower:toNode])
        return [self draw:[fromNode getBottomEdge] endPoint:[toNode getTopEdge]];
    if ([fromNode isHigher:toNode])
        return [self draw:[fromNode getTopEdge] endPoint:[toNode getBottomEdge]];
    
    NSLog(@"CalculateAttachmentPoints (PNEArcView) could not find a suitable attachement point");
}

- (void) drawArc {
    [self calculateAttachmentPoints];
}

@end
