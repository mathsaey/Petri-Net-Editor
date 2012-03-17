//
//  PNETokenView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNETokenView.h"

@implementation PNETokenView

- (id) initWithView:(PNEView*) view {
    if(self = [super init]) {
        tokenColor = [UIColor blackColor];}
    return self;
}

- (id) initWithValues: (PNToken*) pnElement superView: (PNEView*) view {
    if(self = [super init]) {
        element = pnElement;
        superView = view;
        tokenColor = pnElement.color;}
    return self;
}

- (void) drawToken: (CGPoint) origin {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(origin.x, origin.y, TOKEN_DIMENSION, TOKEN_DIMENSION);
    
    CGContextSetFillColorWithColor(context, tokenColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);
    
}

@end
