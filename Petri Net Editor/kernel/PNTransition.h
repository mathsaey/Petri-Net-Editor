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
 * Transitions are the actions on places, its input and output places are just 
 * arays indicating the place and the arity of the flow function
 */

@interface PNTransition : PNNode {
	NSMutableDictionary *inputs; //<place(PNPlace), arity(PNArcInscription)>
	NSMutableDictionary *outputs;	
}

@property(nonatomic,readwrite,copy) NSMutableDictionary *inputs;
@property(nonatomic,readwrite,copy) NSMutableDictionary *outputs;
          
- (void) addInput:(PNArcInscription *) newInscription fromPlace: (PNPlace *) aPlace;
- (void) removeInput: (PNPlace *) placeName;
- (void) addOutput:(PNArcInscription *) newInscription toPlace: (PNPlace *) aPlace;
- (void) removeOutput: (PNPlace *) placeName;
- (BOOL) enabled;
- (NSArray *) normalInputs;
- (NSArray *) inhibitorInputs;
//Returns a 2 position array with a marking of input tokens and a marking of output tokens
- (NSArray *) flow;
- (void) fire;
@end
