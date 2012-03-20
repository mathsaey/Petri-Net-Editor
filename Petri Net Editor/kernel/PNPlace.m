//
//  PNPlace.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 06/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNPlace.h"

@implementation PNPlace 

- (id) init {
	if((self = [super init])) {
		tokens = [[NSMutableArray alloc] init];
		capacity = -1; //default value for infinite capacity
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

- (void) dealloc {
    [tokens release];
    [super dealloc];
}

- (PNPlace *) copyWithName: (NSString *) nodeName {
	PNPlace *newPlace = [[PNPlace alloc] init];
	//newPlace = [super copy];
	[newPlace setTokens: [self tokens]];
	[newPlace setLabel: nodeName];
	return newPlace;
}

- (int) capacity {
    return capacity;
}

- (void) setCapacity:(int)newCapacity {
    capacity = newCapacity;
}

- (NSMutableArray *) tokens {
	return tokens;
}

- (void) setTokens:(NSMutableArray *)newTokens {
	[newTokens retain];
	[tokens release];
	tokens = newTokens;
}

- (BOOL) empty {
	if ([tokens count] == 0) {
		return YES;
	} else {
		return NO;
	}
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
    [addTokens release];
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

- (void) reset:(NSArray *)tokens {
	//@TODO
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@Place "];
    [desc appendString:[self label]];
    [desc appendString:@" ("];
    [desc appendString: [NSString stringWithFormat:@"%d ", [[self tokens] count]]];
    [desc appendString: @"tokens)"];
    return desc;
}

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
    result = prime * result + [self capacity];
    //        For 64bit you might also want to shift and xor.
    //   result = prime * result + (int) ([self capacity] ^ ([self capacity] >>> 32));
    //    For objects you use 0 for nil and otherwise their hashcode.
    result = prime * result + [[self tokens] hash];
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
    [newPlace setCode:code];
    return (newPlace);
}
@end
