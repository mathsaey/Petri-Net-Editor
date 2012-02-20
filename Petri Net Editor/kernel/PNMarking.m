//
//  PNMarking.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 11/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNMarking.h"


@implementation PNMarking

-(id) init {
    if((self = [super init])) {
        markedPlaces = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray *) markedPlaces {
    return markedPlaces;
}

- (void) setMarkedPlaces: (NSMutableArray *) newMarkedPlaces {
    [newMarkedPlaces retain];
    [markedPlaces release];
    markedPlaces = newMarkedPlaces;        
}

- (void) addPlaceToMarking:(PNPlace *)place {
    [markedPlaces addObject:place];
}

-(void) clean {
    [markedPlaces removeAllObjects];
}
@end
