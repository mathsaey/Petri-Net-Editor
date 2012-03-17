//
//  PNEArcView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEArcView.h"

@implementation PNEArcView

@synthesize fromNode, toNode;

- (id) initWithValues: (PNArcInscription*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view]) 
    {
        if ([pnElement flowFunction] == INHIBITOR)
            isInhibitor = TRUE;
        else isInhibitor = FALSE;}
    return self;
}


//We draw an arc in 3 phases
//We calculate a square that lies between the tonode and the end of the line
//Then we draw a line from the fromnode to this square
//We finish by drawing a circle (inhibitor) or an arrow (normal) in the square
- (void) draw: (CGPoint) startPoint endPoint: (CGPoint) endPoint {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Create the triangle startPoint, endPoint, Se. Where SE has the X-value of startPoint and the Y-value of endPoint
    CGFloat SeX = startPoint.x;
    CGFloat SeY = endPoint.y;
    
    //Calculate the angle of Se 
    CGFloat SeAngleOpposite;
    CGFloat SeAngleAdjacent;
    if ((SeAngleOpposite = startPoint.y - SeY) < 0)
        SeAngleOpposite = SeY - startPoint.y;
    if ((SeAngleAdjacent = startPoint.x - endPoint.x) < 0)
        SeAngleAdjacent = endPoint.x - startPoint.x;
    CGFloat SeAngle = atan(SeAngleOpposite / SeAngleAdjacent);
    
    //Calculate the point where the line ends 
    CGFloat lineEndXdistance = ARC_RECT_SIZE * cos(SeAngle);
    CGFloat lineEndYdistance = ARC_RECT_SIZE * sin(SeAngle);
    CGFloat lineEndX;
    CGFloat lineEndY;
    
    if ([fromNode isRight:toNode])
        lineEndX = endPoint.x - lineEndXdistance;
    else lineEndX = endPoint.x + lineEndXdistance;
    
    if ([fromNode isLower:toNode])
        lineEndY = endPoint.y - lineEndYdistance;
    else lineEndY = endPoint.y + lineEndYdistance;
        
    //Draw the Line
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);
    
    //Calculate the square corners
    
    /*
    //Draw the figure inside the square
    if (isInhibitor)
        printf("temp");
    else {
        CGContextMoveToPoint(context, lineEndX + lineEndXdistance / 2, lineEndY + lineEndYdistance / 2);
        CGContextAddLineToPoint(context, lineEndX + lineEndXdistance / 2, lineEndY - lineEndYdistance / 2);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextClosePath(context);

        CGContextStrokePath(context);
    }
    
     */
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
    
    NSLog(@"CalculateAttachmentPoints (PNEArcView )could not find a suitable attachement point");
}

//Draws the arc without updating the from and to members
- (void) reDrawArc {
    [self calculateAttachmentPoints];
}

- (void) drawArc: (PNENodeView*) from transition: (PNENodeView*) to {
    
    fromNode = from;
    toNode = to;
    [self calculateAttachmentPoints];   
}

@end
