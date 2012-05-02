//
//  Place.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 06/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNNode.h"

@class PNToken;

/*
 * A place is a bag of tokens restricted by its upperbound the capacity.
 * If not specified (-1), capacity is assumed to be infinite
 */

@interface PNPlace : PNNode {
@public
	NSMutableArray *tokens;
    NSInteger capacity;
}

///------------------------------------------------------------
/// @name Place Data
///------------------------------------------------------------
/** The (possibly) different activations of a place */
@property(nonatomic, readwrite, retain) NSMutableArray *tokens;
/** The bound of the place (a.k.a how many time can it be activated */
@property(nonatomic, readwrite) NSInteger capacity;
///------------------------------------------------------------
/// @name Initialization & Disposal
///------------------------------------------------------------

/** Initialize a place with a specific name.
 @param placeName The name of the place to initialize.
 @return The initialized place.
 */
- (id)initWithName:(NSString *)placeName;

/**
 Creates a copy of the place with the given name
 */
- (PNPlace *) copyWithName: (NSString *) nodeName;

/**
 Tells whether the place is active.
 @return `YES` if the place is active. `NO` otherwise.
 */
- (BOOL) isActive;

/**
 Method to designate if the place contains a given token
 a.k.a is active in a given thread.
 */
- (BOOL) containsToken:(PNToken *) token;

/**
 Method to designate if the place contains a given collection of tokens
 a.k.a is active in a given collection of threads.
 */
- (BOOL) containsTokens: (NSArray *) serchTokens;

/**
 Adds a new token (Thread activation) to the place
 */
- (void) addToken: (PNToken *) token;

/**
 Adds a new collection of tokens (Thread activations) to the place
 */
- (void) addTokens: (NSArray *) newTokens;

/**
 Removes the given token (deactivates) from the place
 */
- (void) removeToken: (PNToken *) token;

/**
 Removes a given collection of tokens (deactivates) from the place
 */
- (void) removeTokens: (NSArray *) tokenSet;

/** Returns the tocken obkect for a given color
 @param color - The color of the needed tocken
 */
- (PNToken *) getTokenOfColor: (NSNumber *) color;

/**
 Gets the Prepare for activation place of given a place
 */
- (PNPlace *) getPrepareForActivation;

/**
 Gets the Prepare for activation place of given a place
 */
- (PNPlace *) getPrepareForDeactivation;

/**
 Gets the deactivation flag place of given a place
 */
- (PNPlace *) getDeactivationFlag;

/**
 Printable Version of the place
 */
- (NSString *) description;
@end
