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
    PNEPlaceView *tmp = [[PNEPlaceView alloc] init];
    [tmp drawNode:30 yVal:30];
}

@end
