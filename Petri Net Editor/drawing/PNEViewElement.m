//
//  PNEViewElement.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEViewElement.h"

@implementation PNEViewElement

@synthesize element;

#pragma mark - Lifecycle

- (id) initWithValues: (PNElement*) pnElement superView: (PNEView*) view {
    if(self = [super init]) {
        [element retain];
        element = pnElement;
        superView = view;}
    return self;
}

- (void) dealloc {
    [self removeTouchZone];
    [element release];
    [super dealloc];
}

#pragma mark - Touch logic

- (void) updateTouchZone {
    NSLog(@"Abstract version of updateTouchViewLocation (PNEViewElement) called!");
}

- (void) createTouchZone {
    NSLog(@"Abstract version of createTouchView (PNEViewElement) called!");
}

- (void) removeTouchZone {
    NSLog(@"Abstract version of removeTouchView (PNEViewElement) called!");

}

- (void) addTouchResponder: (UIGestureRecognizer*) recognizer {
    NSLog(@"Abstract version of addTouchResponder (PNEViewElement) called!");
}

@end

