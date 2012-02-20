//
//  Place.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 06/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNNode.h"

@class PNToken;

/*
 * A place is a bag of tokens restricted by its upperbound the capacity.
 * If not specified (-1), capacity is assumed to be infinite
 */

@interface PNPlace : PNNode {
	NSMutableArray *tokens;
	int capacity;
}

- (int) capacity;
- (void) setCapacity: (int) newCapacity;
- (PNPlace *) copyWithName: (NSString *) nodeName;
- (NSMutableArray *) tokens;
- (void) setTokens: (NSMutableArray *) newTokens;
- (BOOL) empty;
//returns true if place contain the given tokens
- (BOOL) containsToken:(PNToken *) token;
- (BOOL) containsTokens: (NSArray *) serchTokens;
- (void) addToken: (PNToken *) token;
- (void) addTokens: (NSArray *) newTokens;
- (void) removeToken: (PNToken *) token;
- (void) removeTokens: (NSArray *) tokenSet;
//replace marking
- (void) reset: (NSArray *) tokens;
@end
