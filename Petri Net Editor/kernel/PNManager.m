//
//  PNPetriNet.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 23/06/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNManager.h"
#import "PNTransition.h"
#import "PNMarking.h"
#import "NSDictionary+SetEquals.h"

@implementation PNManager

@synthesize places;
@synthesize transitions, marking;

static PNManager *sharedManager = nil;

+ (PNManager *) sharedManager {
    @synchronized(self) {
        if (!sharedManager) {
            sharedManager = [[PNManager alloc] init];
        }
    }
    
    return sharedManager;   
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (!sharedManager) {
            sharedManager = [super allocWithZone:zone];
            return sharedManager; 
        } else {
            return nil;
        }
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

//- (void)release {
//    // No op (singleton can't be released)
//}

- (id)init {
    if ((self = [super init])) {
        places = [[NSMutableArray alloc] init];
        transitions = [[NSMutableArray alloc] init];
        marking = [[PNMarking alloc] init];
        threadMapping = [[NSMutableDictionary alloc] init]; //<id (NSThread), color (Color)>
    }
    return self;
}

- (void)dealloc {
    [places release];
    [transitions release];
    [marking release];
    [threadMapping release];
    [super dealloc];
}

-(void) addPlaceWithName: (NSString *) placeName {
    NSMutableString *name = [@"p" mutableCopy];
    [name appendString:placeName];
    PNPlace *p = [[PNPlace alloc] initWithName:[NSString stringWithString:name]];
    [self addPlace:p];
    [name release];
    [p release];
}

-(void) addPlace:(PNPlace *)newPlace {
    [places addObject:newPlace];
}

- (void)removePlace:(PNPlace *)aPlace {
    NSParameterAssert(aPlace);
    [places removeObject:aPlace];
}

-(void) addTransition:(PNTransition *)newTransition {
    [transitions addObject:newTransition];
}

- (void) removeTransition: (PNTransition *) transition {
    [transitions removeObject:transition];
}

- (PNPlace *) placeWithName: (NSString *) label {
    for(PNPlace *p in places) {
        if([[p label] isEqualToString:label])
           return p;
    }
    return nil;
}

-(NSArray *) transitionsWithName:(NSString *)label {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *transition in transitions) {
        if([[transition label] isEqualToString:label]) {
            [result addObject:transition];
        }
    }
    return [result autorelease];    
}

-(NSArray *) transitionsForPlace: (NSString *) name {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *t in transitions) {
        if ([[t label] hasSuffix:name]) 
            [result addObject:t];
    }
    return ([result autorelease]);
}

- (NSArray *) incidentTransitionOf: (PNPlace *) place {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (PNTransition *t in transitions) {
        if([[[t inputs] allKeys] containsObject: place] || [[[t outputs] allKeys] containsObject:place] ){
            [result addObject:t];
        }   
    }
    return ([result autorelease]);
}

-(NSMutableArray *) enabledTransitions {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *transition in transitions) {
        if([transition enabled]) {
            [result addObject:transition];
        }
    }
    return [result autorelease];
}

-(NSMutableArray *) enabledTransitionsWithName:(NSString *)transitionLabel {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for(PNTransition *t in transitions) {
        if([[t label] isEqualToString:transitionLabel] && [t enabled]) {
            [results addObject:t];
        }
    }
    return ([results autorelease]);
}

- (void) updateMarking {
    [marking clean];
    for(PNPlace *place in places) {
        if([[place tokens] count] > 0) {
            [marking addPlaceToMarking:place];
        }
    }
}

/**
 * Fire a given transition, it must be checked if the transition is enabled or not
 * in order to fire. in case the transition is not enabled an error signal should be send
 **/
- (void) fireTransition:(PNTransition *)transition {
    if([transition enabled]) {
        [transition fire];
        [self updateMarking];
    } else {
        [NSException raise:@"Transition not available for fireing" format:@"transition %@", [transition description]];
    }
}

/**
 * Fire a transition given its label
 */
- (void) fireTransitionWithName:(NSString *) transitionLabel {
    NSArray *arr = [self enabledTransitionsWithName:transitionLabel];
    if([arr count] != 0) {
        PNTransition *t = [arr objectAtIndex:0];
        [self fireTransition: t];
        [t release];
    }
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@Petri Net \r"];
    for(PNTransition *t in [self transitions]) {
        [desc appendString: [t description]];
        [desc appendString:@"\r"];
    }
    for(PNPlace *p in [self places]) {
        [desc appendString: [p description]];
        [desc appendString:@"\r"];
    }
    return desc;
}
@end
