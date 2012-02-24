//
//  PNETokenView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNETokenView.h"

@implementation PNETokenView

- (void) dealloc {
    [tokenColor dealloc];
    [super dealloc];
}

- (id) initWithValues: (PNToken*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view])
        tokenColor = pnElement.color;
    return self;
}



@end
