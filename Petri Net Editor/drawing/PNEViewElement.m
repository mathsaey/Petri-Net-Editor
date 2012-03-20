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

- (id) initWithView:(PNEView*) view {
    if(self = [super init])
        superView = view;
    return self;
}

- (id) initWithValues: (PNElement*) pnElement superView: (PNEView*) view {
    if(self = [super init]) {
        [element retain];
        element = pnElement;
        superView = view;}
    return self;
}

- (void) dealloc {
    [self deleteTouchView];
    [element release];
    [super dealloc];
}

- (void) moveTouchView:(CGRect)rect {
    touchView.frame = rect;
}

- (void) deleteTouchView {
    [touchView removeFromSuperview];
    [touchView release];
    touchView = NULL;
}

- (void) createTouchView: (CGRect) rect {
    touchView = [[UIView alloc] initWithFrame:rect];
    [superView addSubview:touchView];
}

- (void) addTouchResponder: (UIGestureRecognizer*) recognizer {
    [touchView addGestureRecognizer:recognizer];
}

@end

