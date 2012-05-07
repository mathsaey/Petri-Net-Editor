//
//  PNMarking.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 11/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//


@class PNPlace;

/*
 * Array of currently marked places
 */
@interface PNMarking : NSObject {
	NSMutableArray *activeContexts; 
    NSMutableArray *systemMarking; 
}

///------------------------------------------------------------
/// @name Current Activation Data
///------------------------------------------------------------
//Array marked places in the Petri net
@property(nonatomic,retain) NSMutableArray *activeContexts;
//Current marking to the system (only PNPlace accepted here)
@property(nonatomic,readonly,retain) NSMutableArray *systemMarking;

///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------
/**
 Removes all the tokens from the places in the Petri net
 */
- (void) clean;

/**
 Adds a place to the current marking of the Petri net
 */
- (void) addActiveContextToMarking: (PNPlace *) context;

/**
 Removes a places from the current marking of the Petri net
 */
- (void) removeActiveContextFromMarking: (PNPlace *) context;

/**
 sets the systemMarking as the current marking of the Petri net
 */
- (void) updateSystemState;

/**
 Retrieves all operation in case an instable state
 */
- (void) revertOperation;
@end
