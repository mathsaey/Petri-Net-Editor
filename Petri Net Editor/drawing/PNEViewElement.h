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

@property (readonly) PNElement *element;

- (id) initWithView:(PNEView*) view;
- (id) initWithValues: (PNElement*) pnElement superView: (PNEView*) view;

- (void) deleteTouchView;
- (void) moveTouchView: (CGRect) rect;
- (void) createTouchView: (CGRect) rect;
- (void) addTouchResponder: (UIGestureRecognizer*) recognizer;

@end