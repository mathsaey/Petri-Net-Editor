//
//  PNEContextCollection.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 16/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEContextCollection.h"

@implementation PNEContextCollection

- (void) addTouchresponders {
    for (PNENodeView* node in collection) {
        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoublePanGesture:)];
        tap.minimumNumberOfTouches = 2;
        [node addTouchResponder:tap];
        [tap release];
    }
    
}

- (void) handleDoublePanGesture: (UIPanGestureRecognizer *) gesture {
    ///@todo move all nodes
}

@end
