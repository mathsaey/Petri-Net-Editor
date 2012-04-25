//
//  PNEArcView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "../kernel/PNArcInscription.h"
#import "../PNEConstants.h"

#import "PNEViewElement.h"
#import "PNENodeView.h"


@interface PNEArcView : PNEViewElement <UIActionSheetDelegate> {
    BOOL isInhibitor; /** Keeps track of the ArcInscriptionType of the PNArcInscription this arcview represents */
    int weight; /** Link to the weight of the ArcInscription */
    
    PNENodeView *fromNode; /** The node where the arc starts */
    PNENodeView *toNode; /** The node where the arc arrives */
    
    CGPoint startPoint; /** the point on the fromNode where the arc starts */
    CGPoint endPoint; /** the point on the toNode where the arc ends */
    
    UIActionSheet *options; /** The UIActionSheet that pops up after a long press on the arc */
    NSMutableArray *touchViews; /** A collection of UIViews that catch user input along the arc */
}

- (void) drawArc;

/**
 Updates the nodes that the arc connects
 */
- (void) setNodes: (PNENodeView*) newFromNode toNode: (PNENodeView*) newToNode;

/**
 This function gets called after the arc receives a long press
 */
- (void) handleLongGesture: (UILongPressGestureRecognizer *) gesture;


@end
