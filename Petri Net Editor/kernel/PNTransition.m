//
//  PNTransition.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 08/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNTransition.h"

@implementation PNTransition

@synthesize inputs;
@synthesize outputs;

- (id) init {
	if((self = [super init])) {
        inputs = [NSMutableDictionary dictionary]; //<key (PNPlace), value (NSString type)>
		outputs = [NSMutableDictionary dictionary];	
	}
	return self;
}

- (id) initWithName: (NSString *) aName {
    if((self = [super initWithName: aName])) {
		inputs = [NSMutableDictionary dictionary];
		outputs = [NSMutableDictionary dictionary];	
	}
	return self;
}

- (void) dealloc {
    [super dealloc];
}

- (void) addInput:(PNArcInscription *) newInscription fromPlace: (PNPlace *) aPlace {
	[inputs setObject:newInscription forKey: aPlace];    
}

- (void) removeInput:(PNPlace *) aPlace {
	[inputs removeObjectForKey:aPlace];
}

- (void) addOutput:(PNArcInscription *)newInscription toPlace: (PNPlace *) aPlace {
    if ([newInscription type] == INHIBITOR) {
        @throw ([NSException
                 exceptionWithName:@"InvalidArcInscriptionException"
                 reason:@"It is not posible to have inhibitor arcs for an output"
                 userInfo:nil]);
    } else
        [outputs setObject:newInscription forKey: aPlace];
}

- (void) removeOutput:(PNPlace *) aPlace {
	[outputs removeObjectForKey:aPlace];
}

/**
 * Method to check weather a transition is enabled or not.
 * A transition is enabled if all teh input places have at least the number of tokens
 * described in the flowFunction, or zero if the arc is an inhibitor.
 **/
- (BOOL) enabled {
    BOOL result = YES;
	for(PNPlace* key in [inputs keyEnumerator]){
		unsigned long tokenCount = [[key tokens] count];
        PNArcInscription *ai = [inputs objectForKey:key]; 
		PNInscriptionType aType = [ai type]; 		
		if((aType == NORMAL) && (([[inputs objectForKey:key] flowFunction]) > tokenCount)) {
			result = NO;
		} else if ((aType == INHIBITOR) && (tokenCount != 0)) {
			result = NO;
		}
	}
	return result;
}

- (NSArray *) normalInputs {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNArcInscription *ai in [inputs allValues]) {
        if([ai type] == NORMAL) {
            [result addObject:ai];
        }
    }
    return ([result autorelease]);
}

- (NSArray *) inhibitorInputs {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNArcInscription *ai in [inputs allValues]) {
        if([ai type] == INHIBITOR) {
            [result addObject:ai];
        }
    }
    return ([result autorelease]);
}


/**
 * Remove the flowFunction qunatity of tokens from the input places, assign the flowFunction
 * quantity for the output places
 * @pre: The transition that is being fired is enabled to fire. (to check before calling this method)
 **/
- (void) fire {
	int flow = -1;
	NSMutableArray *tocks;
	NSRange range;
	for(PNPlace *key in [inputs keyEnumerator]) {
        flow = [[inputs objectForKey: key] flowFunction];
        tocks = [key tokens];
        if([tocks count] != 0){
            range.location = [tocks count] - flow;
            range.length = [tocks count] - range.location;
            [tocks removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];      
        }
	}
	for(PNPlace *key in [outputs keyEnumerator]) {
		flow = [[outputs objectForKey:key] flowFunction];
		for(int i=0; i<flow; i++) {
			PNToken *tock = [[[PNToken alloc] init] autorelease];
			[key addToken:tock];
		}
	}
}

- (NSArray *) flow {
    //@TODO not really needed now
	NSMutableArray *markings = [NSMutableArray arrayWithCapacity: 2];
	
	return markings;
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@Transition "];
    [desc appendString:[self label]];
    if([self enabled]){
     [desc appendString:@" (enabled) "];   
    } else {
     [desc appendString:@" (disabled) "];      
    }
    [desc appendString:@"Inputs("];
 /*   for (PNPlace *p in [inputs allKeys]) {
        [desc appendString:@"<"];
        [desc appendString: [p label]];
        [desc appendString:@", "];
        [desc appendString:[[inputs objectForKey:p] description]];
        [desc appendString:@"> | "];
    }
    [desc appendString:@") - Outputs("];
    for (PNPlace *p2 in [outputs allKeys]) {
        [desc appendString:@"<"];
        [desc appendString: [p2 label]];
        [desc appendString:@", "];
        PNArcInscription *a = [outputs objectForKey:p2]; 
        [desc appendString:[[outputs objectForKey:p2] description]];
        [desc appendString:@"> | "];
    }
      [desc appendString:@")"];
    */
    [desc appendString:[inputs description]];
    [desc appendString:@") - Outputs("];
    [desc appendString:[outputs description]];
    [desc appendString:@")"];
    return desc;
}
@end
