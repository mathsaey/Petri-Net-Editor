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
@synthesize enabled;
@synthesize priority;

- (id) init {
	if((self = [super init])) {
        inputs = [NSMutableDictionary dictionary]; //<key (PNPlace), value (NSString type)>
		outputs = [NSMutableDictionary dictionary];	
        enabled = NO;
        priority = 0;
	}
	return self;
}

- (id) initWithName: (NSString *) aName {
    if((self = [super initWithName: aName])) {
		inputs = [NSMutableDictionary dictionary];
		outputs = [NSMutableDictionary dictionary];	
        enabled = NO;
	}
	return self;
}

- (id) initWithName: (NSString *) aName andPriority: (PNTransitionType) newPriority {
    if((self = [super initWithName: aName])) {
		inputs = [NSMutableDictionary dictionary];
		outputs = [NSMutableDictionary dictionary];	
        enabled = NO;
        priority = newPriority;
	}
	return self;
}

- (void) dealloc {
    [super dealloc];
}

///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------
- (void) addInput:(PNArcInscription *) newInscription fromPlace: (PNPlace *) context {
	[inputs setObject:newInscription forKey: context];    
}

- (void) removeInput:(PNPlace *) context {
	[inputs removeObjectForKey:context];
}

- (void) addOutput:(PNArcInscription *)newInscription toPlace: (PNPlace *) context {
    if ([newInscription type] == INHIBITOR) {
        @throw ([NSException
                 exceptionWithName:@"InvalidArcInscriptionException"
                 reason:@"It is not posible to have inhibitor arcs for an output"
                 userInfo:nil]);
    } else
        [outputs setObject:newInscription forKey: context];
}

- (void) removeOutput:(PNPlace *) context {
	[outputs removeObjectForKey:context];
}

- (BOOL) checkEnabledWithColor:(NSNumber *)color {
    enabled = YES;
    for(PNPlace* key in [inputs keyEnumerator]){
		int tokenCount = [[key getTokenOfColor:color] value];
        PNArcInscription *ai = [inputs objectForKey:key]; 
		PNInscriptionType aType = [ai type]; 		
		if((aType == NORMAL) && (([ai flowFunction]) > tokenCount)) {
			enabled = NO;
            break;
		} else if ((aType == INHIBITOR) && (tokenCount != 0)) {
			enabled = NO;
            break;
		}
	}
    if(enabled) {
        for(PNPlace* key2 in [outputs keyEnumerator]){
            PNToken *t = [key2 getTokenOfColor:color];
            PNArcInscription *ai = [outputs objectForKey:key2];
            if([key2 capacity] != -1 && [t value] + [ai flowFunction] > [key2 capacity]) {
                enabled = NO;
                break;
            } 
        }
    }
    return enabled;
}

- (NSArray *) normalInputs {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNPlace *c in [inputs allKeys]) {
        PNArcInscription *ai = [inputs objectForKey:c];
        if([ai type] == NORMAL) {
            [result addObject:c];
        }
    }
    return ([result autorelease]);
}

- (NSArray *) inhibitorInputs {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNPlace *c in [inputs allKeys]) {
        PNArcInscription *ai = [inputs objectForKey:c];
        if([ai type] == INHIBITOR) {
            [result addObject:c];
        }
    }
    return ([result autorelease]);
}

- (void) fireWithColor:(NSNumber *)color {
	int flow;
	for(PNPlace *inpp in [inputs keyEnumerator]) {
        PNArcInscription *ai = [inputs objectForKey:inpp];
        if([ai type] == NORMAL) {
            flow = [[inputs objectForKey:inpp] flowFunction];
            PNToken *t = [inpp getTokenOfColor: color];
            [t setValue:[t value] - flow];
            if([t value] < 1) 
                [inpp removeToken:t];
        }
	}
    for(PNPlace *outp in [outputs keyEnumerator]) {
        flow = [[outputs objectForKey:outp] flowFunction];
        PNToken *tok = [outp getTokenOfColor:color];
        if(tok != nil) {
            [tok setValue:([tok value] + flow)];
        } else {
            PNToken *tock = [[[PNToken alloc] init] autorelease];
            [tock setValue:flow];
            [tock setColor:color];
            [[outp tokens] addObject:tock]; 
        }
	}
}

///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
/**
 * Provides a printable version of the object
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
    for (PNPlace *p in [inputs allKeys]) {
        [desc appendString:@"<"];
        [desc appendString: [p label]];
        [desc appendString:@", "];
        [desc appendString:[[inputs objectForKey:p] description]];
        [desc appendString:@"> | "];
    }
    [desc appendString:@") - Outputs("];
    for (PNPlace *p in [outputs allKeys]) {
        [desc appendString:@"<"];
        [desc appendString: [p label]];
        [desc appendString:@", "];
        [desc appendString:[[outputs objectForKey:p] description]];
        [desc appendString:@"> | "];
    }
    [desc appendString:@")"];
    return desc;
}
@end
