//
//  PNTransition.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 08/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNNode.h"
#import "PNToken.h"
#import "PNPlace.h"
#import "PNArcInscription.h"

@class PNPlace;
@class PNArcInscription;

/*
 Enumeration denoting the priority of the different types of transitions
*/ 
typedef enum {
    EXTERNAL = 0,
    CLEANING = 1,
    INTERNAL = 2
} PNTransitionType;

/*
 Transitions are the actions on places, its input and output places are just 
 arays indicating the place and the arity of the flow function
 */

@interface PNTransition : PNNode {
	NSMutableDictionary *inputs; //<place(PNPlace), arity(PNArcInscription)>
	NSMutableDictionary *outputs;
	BOOL enabled;
    PNTransitionType priority;
}

///------------------------------------------------------------
/// @name Context Data
///------------------------------------------------------------
@property(nonatomic,readwrite,copy) NSMutableDictionary *inputs;
@property(nonatomic,readwrite,copy) NSMutableDictionary *outputs;
@property(nonatomic,readwrite) BOOL enabled;
@property(nonatomic,readwrite) PNTransitionType priority;
///------------------------------------------------------------
/// @name Initialization & Disposal
///------------------------------------------------------------
/** Initialize a context with a specific name.
 @param transitionName The name of the context to initialize.
 @param trnasitionPriority
 @return The initialized context.
 */
- (id) initWithName:(NSString *)newName andPriority: (PNTransitionType) newPriority;

/**
 Adds a new dependency from a context for the (de)activation to take place
 */
- (void) addInput:(PNArcInscription *) newInscription fromPlace: (PNPlace *) context;

/**
 Remove a given dependency from a context to the (de)activation action
 */
- (void) removeInput: (PNPlace *) placeName;

/**
 Adds a new dependency to (de)activate the given context
 */
- (void) addOutput:(PNArcInscription *) newInscription toPlace: (PNPlace *) aPlace;

/**
 Removes the dependency between a (de)activation and the given context
 */
- (void) removeOutput: (PNPlace *) placeName;

/** Method to check weather a transition is enabled or not. A transition is enabled if all teh input places have at least the number of tokens described in the flowFunction, or zero if the arc is an inhibitor.
 @param color - Token color for which the transition should be enabled
 */
- (BOOL) checkEnabledWithColor: (NSNumber *) color;

/**
 Returns all the dependencies for this action to take place
 */
- (NSArray *) normalInputs;

/**
 Returns all inputs from inhibitor arcs for this transition
 */
- (NSArray *) inhibitorInputs;

/**
 Returns all normal inputs for this transition
 */
- (NSArray *) normalInputs;

/** Remove the flowFunction qunatity of tokens from the input places, assign the flowFunction quantity for the output places. Executes the (de)activation for a particular context (given by the label) and its dependent contexts
 @pre The transition that is being fired is enabled to fire. (to check before calling this method)
 @param color - Token color for which the transition will fire
 */
- (void) fireWithColor: (NSNumber *) color;

/** Provides a plain representation of the object
 */
- (NSString *) description;
@end
