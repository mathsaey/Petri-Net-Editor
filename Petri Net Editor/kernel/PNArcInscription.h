//
//  PNArcInscription.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 10/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNElement.h"

/*
 * Arcs are represented by their type and inscription
 * type can be normal or inhibitor, inscription is the arity.
 */
typedef enum {
    NORMAL = 1,
    INHIBITOR = 0
} PNInscriptionType;

@interface PNArcInscription : PNElement {
	int flowFunction;
	PNInscriptionType type;
}

///------------------------------------------------------------
/// @name Current Activation Data
///------------------------------------------------------------
//Array marked places in the Petri net
@property(nonatomic,readwrite) int flowFunction;
//Current marking to the system (only SCContext accepted here)
@property(nonatomic,readwrite) PNInscriptionType type;

- (id) initWithType: (PNInscriptionType) aType;
@end
