//
//  PNEViewElement.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEViewElement.h"

@implementation PNEViewElement

- (id) initWithElement:(id) pnElement {
    if(self == [super init])
        element = pnElement;
    
    return self;
}

- (void) dealloc {
    [element dealloc];
    [super dealloc];
}


@end
