//
//  PNEViewElement.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PNElement;
@class PNEView;

/**
 @author Mathijs Saey

 This class is the visual representation of a PNElement.
 */
@interface PNEViewElement : NSObject {
    id element; /** The PNElement that this viewElement represents */
    PNEView *superView; /** The PNEView that contains the node */
    }

@property (readonly) id element;

- (void) removeElement;
- (id) initWithElement: (PNElement*) pnElement andSuperView: (PNEView*) view;

- (void) removeTouchZone;
- (void) createTouchZone;
- (void) updateTouchZone;
- (void) addTouchResponder: (UIGestureRecognizer*) recognizer;

@end