//
//  PNPlace.m
//  place
//
//  Created by Nicolas Cardozo on 21/03/2012.
//  Copyright 2009 Université catholique de Louvain. All rights reserved.
// 
//

#import "PNContextPlace.h"
#import "PNManager.h"

@implementation PNContextPlace

#pragma mark - Instance creation / descrution

- (id) init {
	if((self = [super init])) {
		capacity = -1; //default value for infinite capacity
	}
	return self;
}

- (id) initWithName:(NSString *) newName {
	if((self = [super initWithName: newName])) {
	}
	return self;
}

- (id) initWithName:(NSString *) newName AndCapacity: (int) newCapacity{
	if((self = [super initWithName: newName])) {
      	capacity = newCapacity;
	}
	return self;
}

- (PNPlace *) copyWithName: (NSString *) nodeName {
	PNPlace *newPlace = [[PNPlace alloc] init];
	//newPlace = [super copy];
	[newPlace setTokens: [self tokens]];
	[newPlace setLabel: nodeName];
	return newPlace;
    
}

- (void)dealloc { 
    [super dealloc]; 
}
///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------

///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@ContextPlace "];
    [desc appendString:[super description]];
    [desc appendString:@" capacity="];
    if(capacity ==  -1)
        [desc appendString:@" Unbounded"];
    else
        [desc appendFormat:@" %d",[self capacity]];
    return desc;

}

@end