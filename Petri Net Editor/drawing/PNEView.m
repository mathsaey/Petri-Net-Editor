//
//  PNEView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 14/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

//This class represents the view where the Petri Net is drawn


#import "PNEView.h"

@implementation PNEView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void) dealloc{
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    PNEArcView *arc = [[PNEArcView alloc] init];
    PNETokenView *token = [[PNETokenView alloc] init];
    PNEPlaceView *place = [[PNEPlaceView alloc] init];
    
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
    [place addToken:token];

    
    [place drawNode:CGPointMake(100, 100)];
    
    [trans0 drawNode:CGPointMake(0, 0)];
    [trans1 drawNode:CGPointMake(0, 100)];
    [trans2 drawNode:CGPointMake(0, 200)];
    [trans3 drawNode:CGPointMake(100, 0)];
    [trans4 drawNode:CGPointMake(200, 0)];
    [trans5 drawNode:CGPointMake(200, 100)];
    [trans6 drawNode:CGPointMake(200, 200)];
    [trans7 drawNode:CGPointMake(100, 200)];
    
    [arc drawArc:place transition:trans0];
    [arc drawArc:place transition:trans1];
    [arc drawArc:place transition:trans2];
    [arc drawArc:place transition:trans3];
    [arc drawArc:place transition:trans4];
    [arc drawArc:place transition:trans5];
    [arc drawArc:place transition:trans6];
    [arc drawArc:place transition:trans7];


   
    
}

@end
