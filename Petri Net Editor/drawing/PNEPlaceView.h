//
//  PNEPlaceView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "../kernel/PNPlace.h"
#import "PNETokenView.h"
#import "PNENodeView.h"

@interface PNEPlaceView : PNENodeView {
    NSMutableArray *tokens; /** The collection of PNETokenView that are part of this place */
    CGFloat distanceFromMidPoint; /** The horizontal and vertical distance of a point on the circle in relation to the midpoint */
    CGFloat midPointX; /** The X value of the midpoint of the place */
    CGFloat midPointY; /** The Y value of the midpoint of the place */
}

/**
 Updates the token array depending on the amount of token the matchin PNPlace contains
 */
- (void) updatePlace;

/**
 Adds a PNETokenView to the token array
 */
- (void) addToken: (PNETokenView*) token;

@end
