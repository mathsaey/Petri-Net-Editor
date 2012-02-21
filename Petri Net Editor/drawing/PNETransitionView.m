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
    if (self = [super init])
        dimensions = TRANSITION_DIMENSION;
    return self;
}

- (id) initWithElement:(PNTransition*) pnElement{
    if (self = [super initWithElement:pnElement])
        dimensions = TRANSITION_DIMENSION;
    return self;
}

- (void) drawNode: (CGFloat) xVal yVal: (CGFloat) yVal {
    
    [super drawNode:xVal yVal:yVal];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rect);
    
}


@end
