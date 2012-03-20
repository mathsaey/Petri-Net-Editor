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

    [trans_1 addOutput:arc_1 toPlace:place_3];
    [trans_1 addInput:arc_2 fromPlace:place_2];
    [trans_2 addInput:arc_3 fromPlace:place_1];
    [trans_3 addInput:arc_4 fromPlace:place_2];
    [trans_2 addInput:arc_5 fromPlace:place_3];

    
    [place_1 addToken:token_1];
    [place_2 addToken:token_2];
    [place_2 addToken:token_3];

    [themanager addPlace:place_1];
    [themanager addPlace:place_2];
    [themanager addPlace:place_3];
    
    [themanager addTransition:trans_1];
    [themanager addTransition:trans_2];
    [themanager addTransition:trans_3];
    
    manager = themanager;
    
    [self loadKernel];


    
    
    CGFloat PXVal = 0;
    CGFloat TXVal = 0;
    
    for (PNEPlaceView* place in places) {
        [place drawNode:CGPointMake(PXVal, 10)];
        PXVal += PLACE_DIMENSION + 50;
    }
    
    for (PNETransitionView* trans in transitions) {
        [trans drawNode:CGPointMake(TXVal, 30 + PLACE_DIMENSION + 100)];
        TXVal += TRANSITION_DIMENSION + 50;
    }
    
    for (PNEArcView* arc in arcs) {
        [arc reDrawArc];
    }
    
    /*
     PNEArcView *arc = [[PNEArcView alloc] init];
    PNETokenView *token = [[PNETokenView alloc] init];
    PNEPlaceView *place = [[PNEPlaceView alloc] initWithView:self];
        
    PNETransitionView *trans0 = [[PNETransitionView alloc] initWithView:self];
    PNETransitionView *trans1 = [[PNETransitionView alloc] initWithView:self];
    PNETransitionView *trans2 = [[PNETransitionView alloc] initWithView:self];
    PNETransitionView *trans3 = [[PNETransitionView alloc] initWithView:self];
    PNETransitionView *trans4 = [[PNETransitionView alloc] initWithView:self];
    PNETransitionView *trans5 = [[PNETransitionView alloc] initWithView:self];
    PNETransitionView *trans6 = [[PNETransitionView alloc] initWithView:self];
    PNETransitionView *trans7 = [[PNETransitionView alloc] initWithView:self];
    
    [place addToken:token];
    [place addToken:token];
    [place addToken:token];
    [place addToken:token];
    //[place addToken:token];

    
    [place drawNode:CGPointMake(100, 100)];

    [trans0 drawNode:CGPointMake(0, 0)];
    [trans1 drawNode:CGPointMake(0, 100)];
    [trans2 drawNode:CGPointMake(0, 200)];
    [trans3 drawNode:CGPointMake(100, 0)];
    [trans4 drawNode:CGPointMake(200, 0)];
    [trans5 drawNode:CGPointMake(200, 100)];
    [trans6 drawNode:CGPointMake(200, 200)];
    [trans7 drawNode:CGPointMake(100, 200)];
    
    [trans0 drawLabel];
    [trans1 drawLabel];
    
    //[trans6 highlightNode];
    
    [arc drawArc:place transition:trans0];
    [arc drawArc:place transition:trans1];
    [arc drawArc:place transition:trans2];
    [arc drawArc:place transition:trans3];
    [arc drawArc:place transition:trans4];
    [arc drawArc:place transition:trans5];
    [arc drawArc:place transition:trans6];
    [arc drawArc:place transition:trans7]; 
     */
    
}

@end
