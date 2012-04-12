//
//  PNEView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 14/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PNEView.h"

#import "PNEArcView.h"
#import "PNEPlaceView.h"
#import "PNEViewElement.h"
#import "PNETransitionView.h"

#import "../kernel/PNManager.h"
#import "PNEViewController.h"

@interface PNEView : UIView {
    PNEViewController *controller; 
    NSMutableArray *arcs;
    NSMutableArray *nodes;
        
    PNManager *manager;
    
    BOOL showLabels;
}

@property (atomic, readwrite) BOOL showLabels;
@property (nonatomic, readonly) PNManager *manager;
@property (nonatomic, readonly) NSMutableArray *arcs, *nodes;
@property (nonatomic, readonly) PNEViewController *controller;

//Methods called from the view controller
- (void) addArc;
- (void) addPlace;
- (void) addTransition;

- (void) loadKernel;
- (void) updatePlaces;


//Testing code
- (void) insertData;

@end
