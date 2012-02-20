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
	NSMutableArray *markedPlaces;
}

- (NSMutableArray *) markedPlaces;
- (void) setMarkedPlaces: (NSMutableArray *) newMarkedPlaces;
- (void) clean;
- (void) addPlaceToMarking: (PNPlace *) place;

@end
