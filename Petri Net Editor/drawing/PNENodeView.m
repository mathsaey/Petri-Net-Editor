//
//  PNENodeView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNENodeView.h"

@implementation PNENodeView

@synthesize xOrig, yOrig, dimensions;

- (void) drawNode: (CGFloat) x yVal: (CGFloat) y{
    xOrig = x;
    yOrig = y;
}

- (id) init {
    if (self = [super init])
        dimensions = 10;
    return self;
}

- (id) initWithElement:(id) pnElement{
    if (self = [super initWithElement:pnElement])
        dimensions = 10;
    return self;
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

- (BOOL) isLower: (PNENodeView*) node{
    return node.yOrig > yOrig + dimensions;
}

- (BOOL) isHigher: (PNENodeView*) node{
    return node.yOrig + node.dimensions < yOrig;
}

- (BOOL) isLeft: (PNENodeView*) node{
    return node.xOrig + node.dimensions < xOrig;
}

- (BOOL) isRight: (PNENodeView*) node{
    return node.xOrig > xOrig + dimensions;
}

- (void) multiplyDimension:(CGFloat)multiplier {
    dimensions = dimensions * multiplier;
}

@end
