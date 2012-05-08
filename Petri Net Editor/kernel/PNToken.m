//
//  Token.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 08/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNToken.h"


@implementation PNToken

@synthesize value;
@synthesize color;

- (id) init {
	if((self = [super init])) {
		value = 1;
        color = [[NSNumber alloc] initWithInt:1]; //default "black" color
	}
	return self;
}

- (BOOL) isEqual:(id)object {
/*    if ([self value] != [(PNToken *)object value])
        return NO;
*/    if (![[self color] isEqualToNumber: [(PNToken *)object color]])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    int prime = 31;
    NSUInteger result = 1;
    //    Then for every primitive you do
    result = prime + [self value];
    //        For 64bit you might also want to shift and xor.
    //   result = prime * result + (int) ([self capacity] ^ ([self capacity] >>> 32));
    //    For objects you use 0 for nil and otherwise their hashcode.
    result = prime * result + [[self color] hash];
    //    For booleans you use two different values
    //    result = prime * result + (var)?1231:1237;
    return result;
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    /*
    PNToken *newToken = [[PNToken allocWithZone:zone] init];
    //   NSLog(@"_copy: %@", [newPlace self]);
    [newToken setValue:[self value]];
    [newToken setColor: [self color]];
    return (newToken);
     */
    return [self retain];
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@Token: "];
    [desc appendString:[NSString stringWithFormat:@"%d #",[[self color] integerValue]]];
    [desc appendString: [NSString stringWithFormat:@"%d ", [self value]]];
    return desc;
}

@end
