//
//  PNArcInscription.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 10/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNArcInscription.h"


@implementation PNArcInscription

@synthesize flowFunction;
@synthesize type;

- (id) init {
	if((self = [super init])) {
		type = NORMAL;
		flowFunction = 1;
	}
	return self;
}

-(id) initWithType: (PNInscriptionType) aType {
    if ((self = [super init])) {
        type = aType;
        if(aType == INHIBITOR)
            flowFunction = 0;
        else
            flowFunction = 1;
    }
    return self;
}

- (BOOL) isEqual:(id)object {
    if([self flowFunction] != [object flowFunction])
        return NO;
    if ([self type] != [(PNArcInscription *)object type])
        return NO;
    return YES;
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    PNArcInscription *newArcInscription = [[PNArcInscription allocWithZone:zone] init];
    NSLog(@"_copy: %@", [newArcInscription self]);
    [newArcInscription setFlowFunction:[self flowFunction]];
    [newArcInscription setType:[self type]];
    return (newArcInscription);
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@""];
    if(type == NORMAL)     
        [desc appendString:@"N x"];
    else
        [desc appendString:@"I x"];   
    [desc appendString:[NSString stringWithFormat:@"%d", [self flowFunction]]];
    return desc;
}
@end
