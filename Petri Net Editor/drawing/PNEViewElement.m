//
//  PNEViewElement.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEViewElement.h"

@implementation PNEViewElement

- (id) initWithView:(PNEView*) view {
    if(self = [super init])
        superView = view;
    return self;
}

- (id) initWithValues: (PNElement*) pnElement superView: (PNEView*) view {
    if(self = [super init]) {
        element = pnElement;
        superView = view;}
    return self;
}

- (void) dealloc {
    [touchView dealloc];
    [element dealloc];
    [super dealloc];
}

- (void) createTouchView: (CGRect) rect {
    touchView = [[UIView alloc] initWithFrame:rect];
    [superView addSubview:touchView];
}

- (void) addTouchResponder: (UIGestureRecognizer*) recognizer {
    [touchView addGestureRecognizer:recognizer];
}

@end
