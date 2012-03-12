//
//  PNETransitionView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNETransitionView.h"

@implementation PNETransitionView

- (id) init {
    if (self = [super init]) {
        dimensions = TRANSITION_DIMENSION;        
    }
    return self;
}

- (id) initWithView:(PNEView*) view {
    if (self = [super initWithView:view]) 
        dimensions = TRANSITION_DIMENSION;
    return self;
}

- (id) initWithValues: (PNTransition*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view])
        dimensions = TRANSITION_DIMENSION;
    return self;
}

- (void) highlightNode {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_WIDTH / 2, yOrig - HL_WIDTH / 2, dimensions + HL_WIDTH, dimensions + HL_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, HL_WIDTH);
    CGContextStrokeRect(context, rect);
}

//Needs a relook, quickly made before demo
- (void) dimNode {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_WIDTH / 2, yOrig - HL_WIDTH / 2, dimensions + HL_WIDTH, dimensions + HL_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, HL_WIDTH);
    CGContextStrokeRect(context, rect);
}

- (void) drawNode: (CGPoint) origin {
    [super drawNode:origin];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);

    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rect);
}

@end
