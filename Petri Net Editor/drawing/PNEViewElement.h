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


@interface PNEViewElement : NSObject {
    PNElement *element;
    PNEView *superView;
    UIView *touchView;
}

- (id) initWithView:(PNEView*) view;
- (id) initWithValues: (PNElement*) pnElement superView: (PNEView*) view;

//Adds a subview to handle touch events
- (void) createTouchView: (CGRect) rect;
//Add touch handles to the subview
- (void) addTouchResponder: (UIGestureRecognizer*) recognizer;

@end