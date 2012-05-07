//
//  PNTemporaryPlace.m
//  context
//
//  Created by NicolasCardozo on 20/03/12.
//  Copyright 2012 Université catolique de Louvain. All rights reserved.
//

#import "PNTemporaryPlace.h"


@implementation PNTemporaryPlace

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    [super dealloc];
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    /*
    PNTemporaryPlace *newPlace = [[PNTemporaryPlace allocWithZone:zone] init];
    [newPlace setLabel:[self label]];
    [newPlace setTokens: [self tokens]];
    [newPlace setCapacity: [self capacity]];
    return (newPlace);
     */
    return [self retain];
}
@end
