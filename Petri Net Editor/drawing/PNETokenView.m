//
//  PNETokenView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNETokenView.h"

@implementation PNETokenView

#pragma mark - Lifecycle
/**
 @see PNEViewElement#initWithValues:superView:
 */
- (id) initWithValues: (PNToken*) pnElement superView: (PNEView*) view {
    if(self = [super init]) {
        element = pnElement;
        superView = view;
        tokenColor = pnElement.color;}
    return self;
}

#pragma mark - Drawing

/**
 Draws a token on a certain location
 @param origin
    The location where the upper left point of the token should be
 */
- (void) drawToken: (CGPoint) origin {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(origin.x, origin.y, TOKEN_DIMENSION, TOKEN_DIMENSION);
    
    //CGContextSetFillColorWithColor(context, tokenColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);
}

@end
