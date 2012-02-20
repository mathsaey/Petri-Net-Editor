//
//  PetriNet.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 23/06/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

@class PNPlace;
@class PNTransition;
@class PNMarking;
@class PNArcInscription;
/*
 * Representation of a petri net
 */
@interface PNManager : NSObject {
    NSMutableArray *places;
    NSMutableArray *transitions;
    PNMarking *marking;
    NSMutableDictionary *threadMapping;
}
///------------------------------------------------------------
/// @name Petri Net Manager Data
///------------------------------------------------------------
/** All the transitions registered in the system. 
 @see PNTransition
 */
@property(nonatomic,readonly,copy) NSMutableArray *transitions;
/** All the places registered in the system.
 @see PNPlace
 */
@property(nonatomic,readonly,copy) NSMutableArray *places;
/** Current marking of the system
 @see PNMarking
 */
@property(nonatomic,readonly,copy) PNMarking *marking;

/** Returns the single instance of PetriNetManager (singleton)
 @return The single intance of PNManager.
 */
+ (PNManager *) sharedManager;

/** Adds a place into the system.
 @param newPlace The place to be added.
 */
- (void) addPlace: (PNPlace *) newPlace;

/** Retrieves a context from its name.
 @param contextName The name of the context to retrieve.
 @return The context related to the given name. If `NO` context is found for this name, it 
 returns a nil value.
 */
- (void) addPlaceWithName: (NSString *) placeName;

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
 Returns all transitions with the given name.
 @param label 
 @return NSArray
 */
- (NSArray *) transitionsWithName: (NSString *) label; 

/**
 Returns and Array with all the enabled transitions.
 */
- (NSMutableArray *) enabledTransitions;

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
 */
- (void) updateMarking;

/** Fires a transition given its name
 @param transitionLabel The name of the transition to be fire
 */
- (void) fireTransitionWithName: (NSString *) transitionLabel;

/** Fires a given transition
 @param transition The transition to be fire
 */
- (void) fireTransition: (PNTransition *) transition;
@end


/**
 Interface to manage the definition of relationshipts between two places 
 and the composition of two Petri nets
 */
@interface PNManager (DependencyRelations)
/** Create exclusion link between two places.
 @param source - Source PNPlace.
 @param target - Target PNPlace.
 */
- (void) addExclusionFrom:(PNPlace *)source to:(PNPlace *) target;

/** Create weak inclusion between the source and target places.
 @param source - Source PNPlace.
 @param target - Target PNPlace.
 */
- (void) addWeakInclusionFrom:(PNPlace *) source to:(PNPlace *) target;

/** Create strong inclusion between the source and target places.
 @param source - Source PNPlace.
 @param target - Target PNPlace.
 */
- (void) addStrongInclusionFrom:(PNPlace *)source to:(PNPlace *)target;

/** Create requirement dependency of the target context to the source context.
 @param source : PNPlace
 @param target : PNPlace
 */
- (void) addRequirementTo:(PNPlace *)source of:(PNPlace *)target;

/** Create composition dependency of the two source context. The result is a composition
 * relation between the two given contexts and the new composed one (source1+source2)
 @param source : PNPlace
 @param source : PNPlace
 */
- (void) addComposedContextsOf:(PNPlace *)source1 and:(PNPlace *) source2;

/**
 Basic method for the composition of one of the basic elements with the current contexts
 */
- (void) composeTransition:(PNTransition *) nTransition with:(PNArcInscription *) nArcInscription fromInput:(PNPlace *) nPlace;

/**
 Basic method for the composition of one of the basic elements with the current contexts
 */
- (void) composeTransition:(PNTransition *) nTransition with:(PNArcInscription *) nArcInscription toOutput:(PNPlace *) nPlace;

/**
 Method to clean up repeated dependencies when composing rules to existing contexts
 */
- (void) trimRepeatedTransitions;

/**
 Method for the composition of a requirement dependency with other dependencies
 */
- (void) checkRequirementConditionFor: (PNTransition *) nTransition from: (PNPlace *) nPlace;

/**
 Adds the necessary extra transitions between the different contexts when composing a requirement
 dependency with another kind of dependency
 */
- (void) addRequirementTransitionsFor: (PNPlace *) source target: (PNPlace *) target;

/**
 Checks if the context given as a parameter is part of a composition dependency
 */
- (BOOL) isComposed: (PNPlace *) place;

/**
 Specific method for the composition of two compose dependencies with a common context
 */
- (void) compose: (PNPlace *) source withComposition: (PNPlace *) composed;
@end
