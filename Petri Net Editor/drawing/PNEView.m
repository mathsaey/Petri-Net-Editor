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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self = [super initWithFrame:frame]) {
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
    
    [manager release];
    [super dealloc];    
}

#pragma mark - External input

- (void) addArc {
    //pick 2 nodes
    //Add gesture recognizers to all nodes, remove them afterwards
}

- (void) addPlace {
    PNPlace *newPlace = [[PNPlace alloc] initWithName:@"New Place"];
    [manager addPlace:newPlace];
    [self loadKernel];
}

- (void) addTransition {
    PNTransition *newTrans = [[PNTransition alloc] initWithName:@"New Transition"];
    [manager addTransition:newTrans];
    [self loadKernel];
}

- (void) drawFromKernel: (PNManager*) kernel {
    manager = kernel;
    [self loadKernel];
}

#pragma mark - Kernel converting

- (void) loadKernel {
    [arcs removeAllObjects];
    [places removeAllObjects];
    [transitions removeAllObjects];
     
    //Load all Places
    for (PNPlace* place in manager.places) {
        [[PNEPlaceView alloc] initWithValues:place superView:self];
    }
    //Load all transitions    
    for (PNTransition* trans in manager.transitions) {
        [[PNETransitionView alloc] initWithValues:trans superView:self];
    }
    
    [self calculatePositions];
}

//Only updates the tokens after firing a transition
- (void) updatePlaces {
    for (PNEPlaceView* place in places) {
        [place updatePlace];
    }
    [self setNeedsDisplay];
}

#pragma mark - Drawing Code

//Redraws the entire graph, should only be used after loading a kernel
- (void) calculatePositions {
    CGFloat horizontalDistance = 100;
    CGPoint currentLocation = CGPointMake(START_OFFSET_X, START_OFFSET_Y);
    
    for (PNEPlaceView* node in places) {
        [node moveNode:currentLocation];
        
        if (currentLocation.x >= self.bounds.size.width) {
            currentLocation.x = self.bounds.origin.x + horizontalDistance;
            currentLocation.y += 100;
        }
        else currentLocation.x += horizontalDistance;
        
        //Add touch responders
        [node createTouchZone];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:node action:@selector(handleTapGesture:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:node action:@selector(handlePanGesture:)];
        UILongPressGestureRecognizer *hold = [[UILongPressGestureRecognizer alloc] initWithTarget:node action:@selector(handleLongGesture:)];
        [node addTouchResponder:tap];
        [node addTouchResponder:pan];
        [node addTouchResponder:hold];
    }
    
    for (PNETransitionView* trans in transitions) {
        [trans moveNode:currentLocation];
        
        if (currentLocation.x >= self.bounds.size.width) {
            currentLocation.x = self.bounds.origin.x + horizontalDistance;
            currentLocation.y += 100;
        }
        else currentLocation.x += horizontalDistance;
        
        //Add touch responders
        [trans createTouchZone];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:trans action:@selector(handleTapGesture:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:trans action:@selector(handlePanGesture:)];
        UILongPressGestureRecognizer *hold = [[UILongPressGestureRecognizer alloc] initWithTarget:trans action:@selector(handleLongGesture:)];
        [trans addTouchResponder:tap];
        [trans addTouchResponder:pan];
        [trans addTouchResponder:hold];
    }
    
    [self setNeedsDisplay];
}

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
        PNPlace* place_5 = [[PNPlace alloc] initWithName:@"Place 5"];
        
        
        PNTransition* trans_1 = [[PNTransition alloc] initWithName:@"Trans 1"];
        PNTransition* trans_2 = [[PNTransition alloc] initWithName:@"Trans 2"];
        PNTransition* trans_3 = [[PNTransition alloc] initWithName:@"Trans 3"];
        
        PNToken* token_1 = [[PNToken alloc] init];
        PNToken* token_2 = [[PNToken alloc] init];
        PNToken* token_3 = [[PNToken alloc] init];
        
        
        [place_1 addToken:token_1];
        [place_2 addToken:token_2];
        [place_2 addToken:token_3];
        
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
        [manager addPlace:place_5];
        
        [manager addTransition:trans_1];
        [manager addTransition:trans_2];
        [manager addTransition:trans_3]; 
    
    [self loadKernel];
}

@end
