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

#import "../UITextView+utils.h"
#import "../kernel/PNManager.h"
#import "PNEViewController.h"

/**
 @author Mathijs Saey
 
 This class is the view that handles the representation and ordering of the Petri Net.
 
 It contains the functions that load the PNManager into a set containing PNEViewElement and stores those elements.
 It also contains the functions that draws the view elements as a consistent whole.
 */
@interface PNEView : UIView {
    NSMutableArray *arcs; /** Array that contains every PNEArcView the view contains */
    NSMutableArray *places; /** Array that keeps track of every PNEPlaceView the view contains */
    NSMutableArray *transitions; /** Array that stores every PNETransitionView the view contains */
        
    PNManager *manager; /** Link to the PNManager that we wish to display */
    
    UITextView *log; /** Link to the log textview */
    UITextView *contextInformation; /** Link to the context information textview */
    
    BOOL showLabels; /** Boolean that stores if we should display node labels */
    
    //Arc adding logic
    BOOL isAddingArc; /** True when the user is in the process of adding an arc */
    PNEPlaceView* arcPlace; /** Selected place while adding an arc */
    PNETransitionView* arcTrans; /** Selected transition while adding and arc */
}

@property (atomic, readwrite) BOOL showLabels;
@property (nonatomic, readwrite, assign) UITextView *log;
@property (nonatomic, readwrite, assign) UITextView *contextInformation;

@property (nonatomic, readonly) PNManager *manager;
@property (nonatomic, readonly) NSMutableArray *arcs;
@property (nonatomic, readonly) NSMutableArray *places;
@property (nonatomic, readonly) NSMutableArray *transitions;

//Adding elements
- (void) addArc;
- (void) addPlace;
- (void) addTransition;

- (void) resetPositions;
- (UIImage *) getPetriNetImage;

//PNElement events
- (void) placeTapped: (PNEPlaceView*) place;
- (void) transitionTapped: (PNETransitionView*) trans;

//Kernel
- (void) loadKernel;
- (void) updatePlaces;

//Testing code
- (void) insertData;

@end
