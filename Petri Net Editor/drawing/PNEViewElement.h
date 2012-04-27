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
 @author Mathijs Saey

 This class is the visual representation of a PNElement.
 */
@interface PNEViewElement : NSObject {
    PNElement *element; /** The PNElement that this viewElement represents */
    PNEView *superView; /** The PNEView that contains the node */
    }

@property (readonly) PNElement *element;

- (id) initWithValues: (PNElement*) pnElement superView: (PNEView*) view;

- (void) removeTouchZone;
- (void) createTouchZone;
- (void) updateTouchZone;
- (void) addTouchResponder: (UIGestureRecognizer*) recognizer;

@end