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
- (id) initWithElement: (PNToken*) pnElement andSuperView: (PNEView*) view {
    if(self = [super init]) {
        element = pnElement;
        superView = view;
        tokenColor = [self lookupColor:pnElement.color];}
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
    
    CGContextSetFillColorWithColor(context, tokenColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);
    
    //Restore the color
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);

}

/**
 This enumeration contains colors matching the NSNumber
 colors used in the kernel.
 */
typedef enum {
    BLACK = 1,
    RED = 2,
    BLUE = 3,
    PURPLE = 4,
    YELLOW = 5,
    GREEN = 6
} PNETokenColor;

/**
 This function looks up the CGColor of a certain code
 @param code
    The code we should look up
 @return
    The color
 */
- (CGColorRef) lookupColor: (NSNumber*) code {
    int ref = [code integerValue];
    switch (ref) {
        case BLACK:
            return [UIColor blackColor].CGColor;
            break;
        case RED:
            return [UIColor redColor].CGColor;
            break;  
        case BLUE:
            return [UIColor blueColor].CGColor;
            break;
        case PURPLE:
            return [UIColor purpleColor].CGColor;
            break;
        case YELLOW:
            return [UIColor yellowColor].CGColor;
            break;
        case GREEN:
            return [UIColor greenColor].CGColor;
            break;
        default:
            NSLog(@"lookupColorCode (PNETokenView) could not find matching color code! proceeding with default color");
            return [UIColor blackColor].CGColor;
            break;
    }
}

@end
