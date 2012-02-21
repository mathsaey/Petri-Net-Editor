//
//  PNETokenView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEPlaceView.h"
#import "PNEViewElement.h"
#import "PNToken.h"


@interface PNETokenView : PNEViewElement {
    PNEPlaceView* thePlace;
    UIColor* tokenColor;
}

- (void) addTokenToPlace: (PNEPlaceView*) newPlace;
- (id) initWithElement:(PNToken*)pnElement;

@end
