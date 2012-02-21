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
        [[NSArray alloc] init];
    }
    return self;
}

- (void) dealloc{
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    PNEArcView *arc = [[PNEArcView alloc] init];
    PNEPlaceView *place = [[PNEPlaceView alloc] init];
    
    PNETransitionView *trans = [[PNETransitionView alloc] init];
    PNETransitionView *trans1 = [[PNETransitionView alloc] init];
    PNETransitionView *trans2 = [[PNETransitionView alloc] init];
    PNETransitionView *trans3 = [[PNETransitionView alloc] init];
    PNETransitionView *trans4 = [[PNETransitionView alloc] init];
    PNETransitionView *trans5 = [[PNETransitionView alloc] init];
    PNETransitionView *trans6 = [[PNETransitionView alloc] init];
    PNETransitionView *trans7 = [[PNETransitionView alloc] init];

    [place drawNode:100 yVal:100];
    
    [trans drawNode:0 yVal:0];
    [trans1 drawNode:0 yVal:100];
    [trans2 drawNode:0 yVal:200];
    [trans3 drawNode:100 yVal:0];
    [trans4 drawNode:200 yVal:0];
    [trans5 drawNode:200 yVal:100];
    [trans6 drawNode:200 yVal:200];
    [trans7 drawNode:100 yVal:200];

    
    [arc drawArc:place transition:trans];
    [arc drawArc:place transition:trans1];
    [arc drawArc:place transition:trans2];
    [arc drawArc:place transition:trans3];
    [arc drawArc:place transition:trans4];
    [arc drawArc:place transition:trans5];
    [arc drawArc:place transition:trans6];
    [arc drawArc:place transition:trans7];


   
    
}

@end
