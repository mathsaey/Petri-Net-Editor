//
//  PNToken.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 08/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//
#import "PNElement.h"

/*
 * Token elements go into places, a token in a place is represented by its multiplicity
 */

@interface PNToken : PNElement {
    int value;
    NSNumber *color;
}

@property(nonatomic, readwrite) int value;
@property(nonatomic, readwrite, retain) NSNumber *color;

-(id) copyWithZone: (NSZone *) zone;

@end
