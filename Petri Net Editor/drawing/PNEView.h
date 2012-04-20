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
    NSMutableArray *arcs;
    NSMutableArray *places;
    NSMutableArray *transitions;
        
    PNManager *manager;
    
    BOOL showLabels;
    
    //Arc adding logic
    BOOL isAddingArc;
    PNEPlaceView* arcPlace;
    PNETransitionView* arcTrans;
}

@property (atomic, readwrite) BOOL showLabels;
@property (nonatomic, readonly) PNManager *manager;
@property (nonatomic, readonly) NSMutableArray *arcs, *places, *transitions;

//Methods called from the view controller
- (void) addArc;
- (void) addPlace;
- (void) addTransition;

- (void) placeTapped: (PNEPlaceView*) place;
- (void) transitionTapped: (PNETransitionView*) trans;

- (void) loadKernel;
- (void) updatePlaces;

- (UIImage *) getPetriNetImage;

//Testing code
- (void) insertData;

@end
