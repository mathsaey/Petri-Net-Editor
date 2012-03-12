//
//  PNENodeView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNENodeView.h"
#import "PNEView.h"

@implementation PNENodeView

@synthesize xOrig, yOrig, dimensions, isMarked;


- (id) initWithValues: (PNNode*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view]) {
        isMarked = false;
        label = pnElement.label;
    }
    return self;
}

- (void) highlightNode {
    isMarked = true;
}

- (void) dimNode {
    isMarked = false;
}

- (void) drawNode: (CGPoint) origin {
    xOrig = origin.x;
    yOrig = origin.y;
    [self drawLabel];
}

- (void) drawLabel {
    if (!superView.showLabels)
        return;

    //Prepare the text
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSelectFont(context, MAIN_FONT_NAME, MAIN_FONT_SIZE, kCGEncodingMacRoman);
    
    //Prepare the string
    label = @"tmp";
    NSUInteger textLength = [label length];
    const char *tokenText = [label cStringUsingEncoding: [NSString defaultCStringEncoding]];
    
    //Inverse the text to makeup for the difference between the uikit and core graphics coordinate systems
    CGAffineTransform flip = CGAffineTransformMakeScale(1, -1);
    CGContextSetTextMatrix(context, flip);
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextShowTextAtPoint(context, [self getRightEdge].x + LABEL_DISTANCE , [self getRightEdge].y - LABEL_DISTANCE  , tokenText, textLength);
}

- (CGPoint) getTopEdge {
    return CGPointMake(xOrig + (dimensions / 2) , yOrig);
}

- (CGPoint) getLeftEdge {
    return CGPointMake(xOrig, yOrig + (dimensions / 2));
}

- (CGPoint) getRightEdge {
    return CGPointMake(xOrig + dimensions, yOrig + (dimensions / 2));
}

- (CGPoint) getBottomEdge {
    return CGPointMake(xOrig + (dimensions / 2), yOrig + dimensions);
}

- (CGPoint) getLeftTopPoint {
    return CGPointMake(xOrig, yOrig);
    
}
- (CGPoint) getRightTopPoint {
    return CGPointMake(xOrig + dimensions, yOrig);
    
}
- (CGPoint) getLeftBottomPoint {
    return CGPointMake(xOrig, yOrig + dimensions);
    
}
- (CGPoint) getRightBottomPoint {
    return CGPointMake(xOrig + dimensions, yOrig + dimensions);
}

- (BOOL) isLower: (PNENodeView*) node {
    return node.yOrig > yOrig + dimensions;
}

- (BOOL) isHigher: (PNENodeView*) node {
    return node.yOrig + node.dimensions < yOrig;
}

- (BOOL) isLeft: (PNENodeView*) node {
    return node.xOrig + node.dimensions < xOrig;
}

- (BOOL) isRight: (PNENodeView*) node {
    return node.xOrig > xOrig + dimensions;
}

- (BOOL) isLeftAndLower: (PNENodeView*) node {
    return [self isLeft:node] && [self isLower:node];
}

- (BOOL) isRightAndLower: (PNENodeView*) node {
    return [self isRight:node] && [self isLower:node];
}

- (BOOL) isLeftAndHigher: (PNENodeView*) node {
    return [self isLeft:node] && [self isHigher:node];
}

- (BOOL) isRightAndHigher: (PNENodeView*) node {
    return [self isRight:node] && [self isHigher:node];
}

- (BOOL) doesOverlap: (PNENodeView*) node {
    return 
    //Check if the origin of the node lies within the current node's rectangle
    (xOrig <= node.xOrig && node.xOrig <= xOrig + dimensions &&
    yOrig <= node.yOrig && node.yOrig <= yOrig + dimensions)
    || //Check if the origin of the current node lies within the node's rectangle
    (node.xOrig <= xOrig && xOrig <= node.xOrig + node.dimensions &&
    node.yOrig <= yOrig && yOrig <= node.yOrig + node.dimensions);
    
    
}

- (void) multiplyDimension:(CGFloat)multiplier {
    dimensions = dimensions * multiplier;
}

@end
