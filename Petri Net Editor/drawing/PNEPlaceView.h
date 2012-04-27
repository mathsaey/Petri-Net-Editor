//
//  PNEPlaceView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "../UITextView+utils.h"
#import "../kernel/PNPlace.h"
#import "PNETokenView.h"
#import "PNENodeView.h"

@class PNETransitionView;

/**
 @author Mathijs Saey

 This class is the visual representation of a PNPlace.
 A place is represented by a hollow circle.
 The circle can possibly contain one or more instances of PNETokenView.
 */
@interface PNEPlaceView : PNENodeView {
    NSMutableArray *tokens; /** The collection of PNETokenView that are part of this place */
    NSMutableDictionary *neighbours; /** Contains pointers to all the transitions connected to this place */
    CGFloat distanceFromMidPoint; /** The horizontal and vertical distance of a point on the circle in relation to the midpoint */
    CGFloat midPointX; /** The X value of the midpoint of the place */
    CGFloat midPointY; /** The Y value of the midpoint of the place */
}

- (void) updatePlace;
- (void) addToken: (PNETokenView*) token;
- (void) addNeighbour: (PNETransitionView*) trans isInput: (BOOL) isInput;
- (void) removeNeighbour: (PNETransitionView*) trans;

@end
