//
//  PNEViewElement.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "../kernel/PNElement.h"
@class PNEView;

/**
 This class is the visual representation of a PNElement.
 */
@interface PNEViewElement : NSObject {
    PNElement *element; /** The PNElement that this viewElement represents */
    PNEView *superView; /** The PNEView that contains the node */
    }

@property (readonly) PNElement *element;

/**
 Initialises the PNElement
 @param pnElement
    the manager version of the PNElement
 @param view
    the PNEView that contains the node
 */
- (id) initWithValues: (PNElement*) pnElement superView: (PNEView*) view;

/**
 Removes the touch area
 */
- (void) removeTouchZone;

/**
 Creates an area on the superView that will respond to touch input.
 */
- (void) createTouchZone;

/**
 Updates the location of the touch zone
 */
- (void) updateTouchZone;

/** 
 Adds a touch responder to the touch zone
 */
- (void) addTouchResponder: (UIGestureRecognizer*) recognizer;

@end