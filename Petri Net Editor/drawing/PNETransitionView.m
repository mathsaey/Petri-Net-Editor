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

- (id) initWithValues: (PNTransition*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view])
        dimensions = TRANSITION_DIMENSION;
    return self;
}

- (id) initWithView:(PNEView*) view {
    if (self = [super initWithView:view]) 
        dimensions = TRANSITION_DIMENSION;
    return self;
}


- (void) drawNode: (CGPoint) origin {
    [super drawNode:origin];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);

    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rect);
}

@end
