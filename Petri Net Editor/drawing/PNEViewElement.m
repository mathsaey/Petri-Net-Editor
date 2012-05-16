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

/**
 Initialises the PNElement
 @param pnElement
    the manager version of the PNElement
 @param view
    the PNEView that contains the node
 */
- (id) initWithElement: (PNElement*) pnElement andSuperView: (PNEView*) view {
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

/**
 [abstract]Removes the element from the superview
 and the matching PNElement from the PNManager
 */
- (void) removeElement {
    NSLog(@"Abstract version of removeElement (PNEViewElement) called!");
}

#pragma mark - Touch logic

/**
 [abstract]Updates the location of the touch zone
 */
- (void) updateTouchZone {
    NSLog(@"Abstract version of updateTouchViewLocation (PNEViewElement) called!");
}

/**
 [abstract]Creates an area on the superView that will respond to touch input.
 */
- (void) createTouchZone {
    NSLog(@"Abstract version of createTouchView (PNEViewElement) called!");
}

/**
 [abstract] Removes the touch area
 */
- (void) removeTouchZone {
    NSLog(@"Abstract version of removeTouchView (PNEViewElement) called!");

}

/** 
 [abstract]Adds a touch responder to the touch zone
 @param recognizer
    the UIGestureRecognizer to add
 */
- (void) addTouchResponder: (UIGestureRecognizer*) recognizer {
    NSLog(@"Abstract version of addTouchResponder (PNEViewElement) called!");
}

@end

