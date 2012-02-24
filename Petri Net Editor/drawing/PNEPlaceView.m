//
//  PNEPlaceView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEPlaceView.h"

@implementation PNEPlaceView

- (id) init {
    if (self = [super init]) { 
        [tokens init];
        dimensions = PLACE_DIMENSION;}
    return self;
}

- (id) initWithView:(PNEView*) view {
    if (self = [super initWithView:view])
        dimensions = PLACE_DIMENSION;
    return self;
}

- (id) initWithValues: (PNPlace*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues: pnElement superView: view]) {
        [tokens init];
        dimensions = PLACE_DIMENSION;} 
    return self;
}

- (void) dealloc {
    [tokens dealloc];
    [super dealloc];
}

- (void) updateMidPoint {
    midPointX = xOrig + dimensions / 2;
    midPointY = yOrig + dimensions / 2;
    distanceFromMidPoint = (dimensions/2) / sqrt(2);
}

- (void) multiplyDimension: (CGFloat) multiplier {
    [super multiplyDimension:multiplier];
    [self updateMidPoint];
}


- (CGPoint) getLeftTopPoint {
   return CGPointMake(midPointX - distanceFromMidPoint, midPointY - distanceFromMidPoint);
}

- (CGPoint) getRightTopPoint {
    return CGPointMake(midPointX + distanceFromMidPoint, midPointY - distanceFromMidPoint);
}

- (CGPoint) getLeftBottomPoint {
    return CGPointMake(midPointX - distanceFromMidPoint, midPointY + distanceFromMidPoint);
}
- (CGPoint) getRightBottomPoint; {
    return CGPointMake(midPointX + distanceFromMidPoint, midPointY + distanceFromMidPoint);
}


- (void) drawNode:(CGFloat)x yVal:(CGFloat)y {
    [super drawNode:x yVal:y];
    [self updateMidPoint];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);
}

@end

/*

 
 
*/