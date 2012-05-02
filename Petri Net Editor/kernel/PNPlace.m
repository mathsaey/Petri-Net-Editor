//
//  PNPlace.m
//  place
//
//  Created by JC & Julien Goffaux on 3/10/09.
//  Reviewed by Damien Rambout.
//  Copyright 2009 Université catholique de Louvain. All rights reserved.
// 
//

#import "PNPlace.h"
#import "PNManager.h"
#import "PNToken.h"


@implementation PNPlace

@synthesize tokens;
@synthesize capacity;

#pragma mark - Instance creation / descrution

- (id) init {
	if((self = [super init])) {
		tokens = [[NSMutableArray alloc] init];
        capacity = -1;
	}
	return self;
}

- (id) initWithName:(NSString *) newName {
	if((self = [super initWithName: newName])) {
		tokens = [[NSMutableArray alloc] init];
		capacity = -1; //default value for infinite capacity
	}
	return self;
}


- (PNPlace *) copyWithName: (NSString *) nodeName {
	PNPlace *newPlace = [[PNPlace alloc] init];
	[newPlace setTokens: [self tokens]];
	[newPlace setLabel: nodeName];
	return newPlace;
}

- (void)dealloc { 
	[tokens release];
    [super dealloc]; 
}

///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------
- (BOOL) isActive {
	return [tokens count] > 0;
}

- (BOOL) containsToken:(PNToken *)token {
	NSArray *searchTokens = [NSArray arrayWithObject:token];
	return [self containsTokens: searchTokens];
}

- (BOOL) containsTokens:(NSArray *) searchTokens {
	for(PNToken *t in searchTokens) {
		if (![tokens containsObject:t]) {
			return NO;
		}
	}
	return YES;
}

- (void) addToken:(PNToken *)token {
	NSArray *addTokens = [NSArray arrayWithObject:token];
	[self addTokens:addTokens];
}

- (void) addTokens:(NSArray *)newTokens {
	[tokens addObjectsFromArray:newTokens];
}

- (void) removeToken:(PNToken *)token {
	NSArray *removeTokens = [NSArray arrayWithObject:token];
	[self removeTokens:removeTokens];
}

- (void) removeTokens:(NSArray *)tokenSet {
	[tokens removeObjectsInArray:tokenSet];
}

- (PNToken *) getTokenOfColor:(NSNumber *)color {
    for(PNToken *t in tokens)
        if([[t color] isEqualTo:color])
            return t;
    return nil;
}

-(PNPlace *) getPrepareForActivation {
    for (PNPlace *c in [[PNManager sharedManager] temporaryPlaces]) {
        if ([[c label] hasPrefix:@"PR."] && [[c label] hasSuffix:[self label]])
            return c;
    }
    return nil;
}

-(PNPlace *) getPrepareForDeactivation {
    for(PNPlace *c in [[PNManager sharedManager] temporaryPlaces]) {
        if([[c label] hasPrefix:@"PRN."] && [[c label] hasSuffix:[self label]])
            return c;
    }
    return nil;
}

-(PNPlace *) getDeactivationFlag {
    for(PNPlace *c in [[PNManager sharedManager] temporaryPlaces]) {
        if([[c label] hasPrefix:@"NEG."] && [[c label] hasSuffix:[self label]])
            return c;
    }
    return nil;
}
///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:[self label]];
    [desc appendString:@" ("];
    if (![self tokens]) {
        [desc appendString:@"0 tokens)"];
    } else {
        for(PNToken *t in [self tokens]) {
            [desc appendString: [t description]];
        }
        [desc appendString:@")"];
    }
    return desc;
}

/**
 * Two places are said to be equal if they have the same name and same capacity
 */
- (BOOL) isEqual:(id)object {
    if(![[self label] isEqualToString: [object label]])
        return NO;
    if ([self capacity] != [object capacity])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    int prime = 31;
    NSUInteger result = 1;
    //    Then for every primitive you do
    result = prime + [self capacity];
    //        For 64bit you might also want to shift and xor.
    //   result = prime * result + (int) ([self capacity] ^ ([self capacity] >>> 32));
    //    For objects you use 0 for nil and otherwise their hashcode.
    //result = prime * result + [[self tokens] hash];
    result = prime * result + [[self label] hash];
    //    For booleans you use two different values
    //    result = prime * result + (var)?1231:1237;
    return result;
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    PNPlace *newPlace = [[PNPlace allocWithZone:zone] init];
    //   NSLog(@"_copy: %@", [newPlace self]);
    [newPlace setLabel:[self label]];
    [newPlace setTokens:tokens];
    [newPlace setCapacity:capacity];
    return (newPlace);
}

@end