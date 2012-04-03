//
//  PNEView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 14/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEView.h"

@implementation PNEView

@synthesize showLabels;
@synthesize manager;
@synthesize arcs, places, transitions;

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
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
    if (self) {
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

- (void) loadKernel {
    //Load all Places
    for (PNPlace* place in manager.places) {
        [[PNEPlaceView alloc] initWithValues:place superView:self];
    }
    //Load all transitions    
    for (PNTransition* trans in manager.transitions) {
        [[PNETransitionView alloc] initWithValues:trans superView:self];
    }
}

- (void) drawFromKernel: (PNManager*) kernel {
    manager = kernel;
    [self loadKernel];
}

- (void)drawRect:(CGRect)rect
{   
    PNManager* themanager = [[PNManager alloc] init];
        
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
    
    PNArcInscription* arc_1 = [[PNArcInscription alloc] initWithType:NORMAL];
    PNArcInscription* arc_2 = [[PNArcInscription alloc] initWithType:INHIBITOR];
    PNArcInscription* arc_3 = [[PNArcInscription alloc] initWithType:NORMAL];
    PNArcInscription* arc_4 = [[PNArcInscription alloc] initWithType:INHIBITOR];
    PNArcInscription* arc_5 = [[PNArcInscription alloc] initWithType:NORMAL];
    PNArcInscription* arc_6 = [[PNArcInscription alloc] initWithType:NORMAL];
    PNArcInscription* arc_7 = [[PNArcInscription alloc] initWithType:NORMAL];


    [trans_1 addOutput:arc_1 toPlace:place_2];
    [trans_1 addInput:arc_2 fromPlace:place_2];
    [trans_2 addInput:arc_3 fromPlace:place_3];
    [trans_3 addInput:arc_4 fromPlace:place_2];
    [trans_2 addOutput:arc_5 toPlace:place_1];
    [trans_1 addInput:arc_6 fromPlace:place_5];
    [trans_3 addInput:arc_7 fromPlace:place_1];


    
    [place_1 addToken:token_1];
    [place_2 addToken:token_2];
    [place_2 addToken:token_3];

    [themanager addPlace:place_1];
    [themanager addPlace:place_2];
    [themanager addPlace:place_3];
    [themanager addPlace:place_4];
    [themanager addPlace:place_5];

    
    [themanager addTransition:trans_1];
    [themanager addTransition:trans_2];
    [themanager addTransition:trans_3];
    
    manager = themanager;
    
    [self loadKernel];
    
    CGFloat PXVal = 200;
    CGFloat TXVal = 200;
    
    for (PNEPlaceView* place in places) {
        [place drawNode:CGPointMake(PXVal, 100)];
        PXVal += PLACE_DIMENSION + 50;
        [place createTouchView:CGRectMake(place.xOrig, place.yOrig, place.dimensions, place.dimensions)];
        
        UITapGestureRecognizer *tmp = [[UITapGestureRecognizer alloc] initWithTarget:place action:@selector(toggleHighlight)];
        [place addTouchResponder:tmp];
        
    }
    
    for (PNETransitionView* trans in transitions) {
        [trans drawNode:CGPointMake(TXVal, 100 + PLACE_DIMENSION + 100)];
        TXVal += TRANSITION_DIMENSION + 50;
        
        [trans createTouchView:CGRectMake(trans.xOrig, trans.yOrig, trans.dimensions, trans.dimensions)];
        
        UITapGestureRecognizer *tmp = [[UITapGestureRecognizer alloc] initWithTarget:trans action:@selector(toggleHighlight)];
        [trans addTouchResponder:tmp];
    }
    
    for (PNEArcView* arc in arcs) {
        [arc reDrawArc];
    }
    
}

@end
