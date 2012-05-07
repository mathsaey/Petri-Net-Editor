//
//  PNEContextPlaceView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 2/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEContextPlaceView.h"

@implementation PNEContextPlaceView

/**
 This constructor just calls it's super constructor.
 This constructor is overriden to enforce the proper type of PNPlace
 */
- (id)initWithValues:(PNContextPlace *)pnElement superView:(PNEView *)view {
    return [super initWithValues:pnElement superView:view];
}

/**
 Draws the place
 */
- (void) drawNode {
    [super drawNode];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);
}

@end
