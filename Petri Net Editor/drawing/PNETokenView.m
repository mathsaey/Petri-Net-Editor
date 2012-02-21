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
    [thePlace dealloc];
    [super dealloc];
}

- (id) initWithElement:(PNToken*)pnElement {
    if (self = [super initWithElement:pnElement])
        tokenColor = pnElement.color;
    return self;
}

- (void) addTokenToPlace: (PNEPlaceView*) newPlace {
    
}



@end
