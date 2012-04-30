//
//  PNEView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 14/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEView.h"

@implementation PNEView

@synthesize arcs, places, transitions;
@synthesize log, contextInformation;
@synthesize showLabels;
@synthesize manager;

#pragma mark - Lifecycle

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        manager = [[PNManager alloc] init];
        [manager retain];
        showLabels = true;
        arcs = [[NSMutableArray alloc] init];
        places = [[NSMutableArray alloc] init];
        transitions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc{
    [arcs release];
    [places release];
    [transitions release];
    
    [super dealloc];    
}

#pragma mark - External input

/**
 Prepares the view for adding an arc
 */
- (void) addArc {
    if (!isAddingArc) {
        [self dimNodes];
        [self setNeedsDisplay];
        isAddingArc = true;}
    else {
        isAddingArc = false;
        arcPlace = NULL;
        arcTrans = NULL;
        [self dimNodes];
        [self setNeedsDisplay];
    }
}

/**
 Adds the arc to the kernel after a place and transition have been selected
 */
- (void) finishAddingArc: (BOOL) isPlaceFirst {
    PNArcInscription *arc = [[PNArcInscription alloc] initWithType:NORMAL];
    
    if (isPlaceFirst)
        [arcTrans.element addInput: arc fromPlace: arcPlace.element];
    else [arcTrans.element addOutput: arc toPlace: arcPlace.element];
    
    isAddingArc = false;
    arcPlace = NULL;
    arcTrans = NULL;
    
    [self dimNodes];
    [self loadKernel];
    
}

/**
 Creates a new place and adds it to the manager
 */
- (void) addPlace {
    PNPlace *newPlace = [[PNPlace alloc] initWithName:@"New Place"];
    [manager addPlace:newPlace];
    [self loadKernel];
}

/**
 Creates a new transition and adds it to the manager
 */
- (void) addTransition {
    PNTransition *newTrans = [[PNTransition alloc] initWithName:@"New Transition"];
    [manager addTransition:newTrans];
    [self loadKernel];
}

/**
 Occurs when a PNEPlaceView receives a tap touch event.
 This method is located at this level since
 a tap might influence the entire petri net (when adding arcs)
 */
- (void) placeTapped: (PNEPlaceView*) place {
    if (isAddingArc) {
        
        //Deselect a place
        if (arcPlace == place) {
            arcPlace = NULL;
            return [place dim];
        }
        
        [arcPlace dim];
        [place highlight];
        arcPlace = place;
        
        if (arcTrans != NULL)
            [self finishAddingArc:FALSE];
    }
    else [place toggleHighlightStatus];
}

/**
 Occurs when a PNETRansitionView receives a tap touch event.
 This method is located at this level since
 a tap might influence the entire petri net (when adding arcs)
 */
- (void) transitionTapped: (PNETransitionView*) trans {
    if (isAddingArc) {
        
        if (arcTrans == trans) {
            arcTrans = NULL;
            return [trans dim];
        }
        
        [arcTrans dim];
        [trans highlight];
        arcTrans = trans;
        
        if (arcPlace != NULL)
            [self finishAddingArc:TRUE];
    }
}

/**
 Replaces the kernel and draws it.
 @param kernel
    The new kernel to be drawn
 */
- (void) drawFromKernel: (PNManager*) kernel {
    manager = kernel;
    [self loadKernel];
}

/** 
 Returns a UIImage of the PNEView
 @return The UIImage representation of the PNEView
 */
- (UIImage *) getPetriNetImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [[UIScreen mainScreen] scale]);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *pnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pnImage;
}

#pragma mark - Help functions

/**
 Dims all the nodes of the PNEView
 */
- (void) dimNodes {
    for (PNENodeView *node in places) {
        [node dim];
    }
    for (PNENodeView *node in transitions) {
        [node dim];
    }
}

#pragma mark - Kernel converting

/**
 This function creates the view counterpart of the PNManager.
 Every PNPlace and PNTransition get a View counterpart, most of the 
 work of loading the kernel is done while initialising the PNEPlaceView and PNETransitionView.
 
 @see PNEPlaceView#initWithValues:superView:
 @see PNETransitionView#initWithValues:superView:

 */
- (void) loadKernel {
    [arcs removeAllObjects];
    [places removeAllObjects];
    [transitions removeAllObjects];
    
    for (PNPlace* place in manager.places) {
        [[PNEPlaceView alloc] initWithValues:place superView:self];
    }
    for (PNTransition* trans in manager.transitions) {
        [[PNETransitionView alloc] initWithValues:trans superView:self];
    }
    
    [self refreshPositions];
}

/**
 Updates the token arrays of every PNEPlaceView.
 This is generally used after firing a transition.
 */
- (void) updatePlaces {
    for (PNEPlaceView* place in places) {
        [place updatePlace];
    }
    [self setNeedsDisplay];
}

#pragma mark - Drawing Code

/**
 Ensures that no PNENodeView is out of bounds
 This is mainly used after rotating the device
 */
- (void) checkPositions {
    for (PNEPlaceView *place in places) {
        [place moveNode:CGPointMake(place.xOrig, place.yOrig)];
    }
    for (PNETransitionView *trans in transitions) {
        [trans moveNode:CGPointMake(trans.xOrig, trans.yOrig)];
    }
}

/**
 Positions a PNENodeView in the PNEView.
 @param position
    The location where we place the node
 @param node
    The PNENodeView we will place.
 */
- (void) placeNode: (CGPoint*) position node: (PNENodeView*) node {    
    if (position->x + node.dimensions > self.bounds.size.width) {
        position->x = START_OFFSET_X;
        position->y += 100;
    }
    [node moveNode:*position];
}

/**
 Redraws the entire Petri Net, this resets positions of non-new elements
 */
- (void) resetPositions {
    [self updatePositions:true];
}

/**
 Redraws the entire Petri Net without moving non-new elements
 */
- (void) refreshPositions {
    [self updatePositions:false];
}

/**
 This is the method that actually moves around the elements.
 Places are all put on one or more rows.
 Afterwards the same thing is done for the transitions.
 
 @param shouldReset
    If true every element is repositioned.
    If not all elements keep their positions and
    only new elements are moved to a location.
 */
- (void) updatePositions: (BOOL) shouldReset {
    CGPoint currentLocation = CGPointMake(START_OFFSET_X, START_OFFSET_Y);
    CGFloat horizontalDistance = 100;
    
    for (PNEPlaceView* place in places) {
        if (!place.hasLocation || shouldReset) {
            [self placeNode:&currentLocation node:place];
            currentLocation.x += horizontalDistance;
        }
    }
    
    currentLocation.y += 100;
    currentLocation.x = START_OFFSET_X;
    
    for (PNETransitionView* trans in transitions) {
        if (!trans.hasLocation || shouldReset) {
            [self placeNode:&currentLocation node:trans];
            currentLocation.x += horizontalDistance;
        }
    }
    
    [self setNeedsDisplay];
}

/**
 This method is called by the system when the drawing phase starts.
 The drawing phase can be started programatically by calling setNeedsDisplay.
 */
- (void)drawRect:(CGRect)rect {    
    for (PNEPlaceView* place in places) {
        [place drawNode];
    }
    for (PNETransitionView* transition in transitions) {
        [transition drawNode];
    }
    for (PNEArcView* arc in arcs) {
        [arc drawArc];
    }
}

#pragma mark - TestCode

- (void) insertData {  
        
        PNPlace* place_1 = [[PNPlace alloc] initWithName:@"Place 1"];
        PNPlace* place_2 = [[PNPlace alloc] initWithName:@"Place 2"];
        PNPlace* place_3 = [[PNPlace alloc] initWithName:@"Place 3"];
        PNPlace* place_4 = [[PNPlace alloc] initWithName:@"Place 4"];
        
        PNTransition* trans_1 = [[PNTransition alloc] initWithName:@"Trans 1"];
        PNTransition* trans_2 = [[PNTransition alloc] initWithName:@"Trans 2"];
        PNTransition* trans_3 = [[PNTransition alloc] initWithName:@"Trans 3"];
        
        PNToken* token_1 = [[PNToken alloc] init];
        PNToken* token_2 = [[PNToken alloc] init];
        PNToken* token_3 = [[PNToken alloc] init];
        
        
        [place_1 addToken:token_1];
        [place_2 addToken:token_2];
        [place_3 addToken:token_3];
        
        PNArcInscription* arc_1 = [[PNArcInscription alloc] initWithType:NORMAL];
        PNArcInscription* arc_2 = [[PNArcInscription alloc] initWithType:INHIBITOR];
        PNArcInscription* arc_3 = [[PNArcInscription alloc] initWithType:NORMAL];
        PNArcInscription* arc_4 = [[PNArcInscription alloc] initWithType:NORMAL];
        
        [trans_1 addInput:arc_3 fromPlace:place_2];
        [trans_2 addOutput:arc_1 toPlace:place_1];
        [trans_3 addInput:arc_2 fromPlace:place_1];
        
        [trans_1 addOutput:arc_4 toPlace:place_3];
        
        [manager addPlace:place_1];
        [manager addPlace:place_2];
        [manager addPlace:place_3];
        [manager addPlace:place_4];
        
        [manager addTransition:trans_1];
        [manager addTransition:trans_2];
        [manager addTransition:trans_3]; 
    
    [self loadKernel];
}

@end
