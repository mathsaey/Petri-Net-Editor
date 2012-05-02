//
//  PetriNet.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 23/06/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

@class PNPlace;
@class PNInternalTransition;
@class PNTransition;
@class PNMarking;
@class PNArcInscription;

/*
 Enumeration denoting the priority of the different types of transitions
 */ 
typedef enum {
    EXCLUSION = 0,
    WEAK = 1,
    STRONG = 2,
    REQUIREMENT = 3,
    COMPOSITION = 4
} SCDependencyRelations;

/*
 * Representation of a petri net
 */
@interface PNManager : NSObject {
    NSMutableArray *places;
    NSMutableArray *temporaryPlaces;
    NSMutableArray *transitions;
    PNMarking *marking;
    NSMutableArray *transitionQueue;
    NSMutableDictionary *dependencies;
    NSMutableDictionary *threadMapping;
}
///------------------------------------------------------------
/// @name Petri Net Manager Data
///------------------------------------------------------------
/** All the contexts registered in the system. 
 @see Context
 */
@property(nonatomic,readwrite,retain) NSMutableArray *places;
/** All the contexts registered in the system. 
 @see TemporaryPlace
 */
@property(nonatomic,readwrite,retain) NSMutableArray *temporaryPlaces;
/** All the contexts that are currently active. 
 @see PNTransition
 */
@property(nonatomic,readwrite,retain) NSMutableArray *transitions;
/** Que of internal transitions to be fire
 */
@property(nonatomic,readwrite,retain) NSMutableArray *transitionQueue;
/** An array that has all the dependency relations */
@property(nonatomic,readwrite,retain) NSMutableDictionary *dependencies; 
/** Overview of the context that are currently activated in each thread
 @see PNMarking
 */
@property(nonatomic,readwrite,retain) PNMarking *marking;


/** Returns the single instance of PetriNetManager (singleton)
 @return The single intance of PNManager.
 */
+ (PNManager *) sharedManager;

/**
 Initialize the petri net by setting up the initial marking (@TODO) 
 and eneabling the respective transitions
 */
//-(void) start;

/** Adds a place into the system.
 @param newPlace The place to be added.
 */
- (void) addPlace: (PNPlace *) newPlace;

/** Create a new context given its name and capacity
 @param contextName - The name of the context
 @param capacity - The bound of the context
 */
- (PNPlace *) addPlaceWithName: (NSString *) contextName AndCapacity: (int) capacity;

/** Create a new context given its
 @param contextName - The name of the context
 */
- (PNPlace *) addPlaceWithName: (NSString *) contextName;

/** Removes a place from the system. 
 @param aPlace The place to be removed from the system.
 */
- (void)removePlace:(PNPlace *)aPlace;

/** Retrieves a place from its name.
 @param label The name of the context to retrieve.
 @return The place related to the given name. If `NO` place is found for this name, it 
 returns nil.
 */
- (PNPlace *) placeWithName: (NSString *) label;

/** Adds a transition into the system.
 @param newTransition -  The transition to be added.
 */
- (void) addTransition: (PNTransition *) newTransition;

/** Removes a transition from the system. 
 @param transition The transition to be removed from the system.
 */
- (void) removeTransition: (PNTransition *) transition;

/** 
 Returns all the inputs of the place
 */
- (NSArray *) getInputsForPlace: (PNPlace *) palce ;

/**
 Returns all the outputs of the place
 */
-(NSArray *) getOutputsForPlace: (PNPlace *) place;

/**
 Adds an enabled internal transition to the queue
 */
- (void) addInternalTransitionToQueue: (PNInternalTransition *) iTransition;

/**
 Checks if there are temporary places currently marked
 */
- (BOOL) isStable;

/** 
 Print all active contexts.
 */
//- (void) printActiveContext;

/** 
 Print all contexts.
 */
//- (void)printAllContext;
@end

@interface PNManager (Updates)
/**
 Returns all transitions with the given name.
 @param label 
 @return NSArray
 */
- (NSArray *) transitionsWithName: (NSString *) label; 

/**
 Returns and Array with all the enabled transitions for a given color.
 @param color -  Color for which we want the transitions
 */
- (NSMutableArray *) enabledTransitionsForColor: (NSNumber *) color;

/**
 Returns and Array with all the enabled transitions with a given name
 */
- (NSMutableArray *) enabledTransitionsWithName: (NSString *) transitionLabel;

/**
 Returns and Array with all the transitions that hava an effect on (are inscident to) 
 the given place name
 */
- (NSArray *) transitionsForPlace: (NSString *) placeName;

/**
 Returns and Array with all the transitions that hava an effect on (are inscident to) given the place
 */
- (NSArray *) incidentTransitionOf: (PNPlace *) place;

/**
 Updates the curentContext with all currently active contexts
 @param color -  A color for which enabled transitions should be check upon
 */
- (void) updateMarkingForColor: (NSNumber *) color;

/** Fires a transition given its name
 @param transitionLabel The name of the transition to be fire
 */
- (BOOL) fireTransitionWithName: (NSString *) transitionLabel;

/** Fire a transition in a given thread
 @param transitionName - Name of the transition to be fired
 @param thread - Thread in which the transition will be fired
 */
-(BOOL) fireTransitionWithName: (NSString *) transitionName InThread: (NSThread *) thread;

/** Fire a transition in a given thread
 @param transition - The transition to be fired
 @param thread - Thread in which the transition will be fired
 */
-(BOOL) fireTransition: (PNTransition *) transition InThread: (NSThread *) thread;

/** Fire a transition in a given thread through its color
 @param transition - The transition to be fired
 @param color - The color corresponding to the thread
 */
-(BOOL) fireTransition: (PNTransition *) transition WithColor: (NSNumber *) color;

/** Fires a given transition
 @param transition The transition to be fired
 */
- (BOOL) fireTransition: (PNTransition *) transition;
@end

/**
 Interface to manage the definition of relationshipts between two places 
 and the composition of two Petri nets
 */
@interface PNManager (DependencyRelations)
/**  Register the relation into the system
 @param source - The source of the relation
 @param target - The target of the relation
 */
- (void) registerDependency: (SCDependencyRelations) type BetweenSource: (PNPlace *) source AndTarget: (PNPlace *) target;

/**
 Remove a dependency relation between two contexts
 @param type - The type of the relation (exclusion, weak ...)
 @param source - The source of the relation
 @param target The target of the relation
 */
- (void) removeDependency: (SCDependencyRelations) type BetweenSource: (PNPlace *) source AndTarget: (PNPlace *) target;

/** Create exclusion link between two places.
 @param source - Source PNPlace.
 @param target - Target PNPlace.
 */
- (void) addExclusionFrom:(PNPlace *)source To:(PNPlace *) target;

/** Create weak inclusion between the source and target places.
 @param source - Source PNPlace.
 @param target - Target PNPlace.
 */
- (void) addWeakInclusionFrom:(PNPlace *) source To:(PNPlace *) target;

/** Create strong inclusion between the source and target places.
 @param source - Source PNPlace.
 @param target - Target PNPlace.
 */
- (void) addStrongInclusionFrom:(PNPlace *)source To:(PNPlace *)target;

/** Create requirement dependency of the target context to the source context.
 @param source : PNPlace
 @param target : PNPlace
 */
- (void) addRequirementTo:(PNPlace *)source Of:(PNPlace *)target;

/**
 Checks the constrains of an exclusion dependency relation
 @param source - a context
 @param target - a context
 */
- (void) checkExclusionConstrains;

/**
 Checks the constrains of an exclusion dependency relation
 @param source - a context
 @param target - a context
 */
- (void) checkWeakInclusionConstrains;

/**
 Checks the constrains of all strong inclusion dependency relations
 */
- (void) checkStrongInclusionConstrains;

/**
 Checks the constrains that need to be fulfilled in a requirement condition
 @param source - a context
 @param target - a context
 */
- (void) checkRequirementConstrains;

/**
 Method to clean up repeated dependencies when composing rules to existing contexts
 */
- (void) trimRepeatedTransitions;

@end
