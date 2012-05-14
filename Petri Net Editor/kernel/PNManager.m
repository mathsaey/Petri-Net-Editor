//
//  PNPetriNet.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 23/06/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNManager.h"
#import "PNPlace.h"
#import "PNContextPlace.h"
#import "PNTemporaryPlace.h"
#import "PNTransition.h"
#import "PNInternalTransition.h"
#import "PNExternalTransition.h"
#import "PNMarking.h"
#import "NSDictionary+SetEquals.h"

@implementation PNManager

@synthesize places, temporaryPlaces;
@synthesize transitions, transitionQueue;
@synthesize marking, dependencies;

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

+ (void) trashManager {
    @synchronized(self) {
        sharedManager = [sharedManager init];
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init {
    if ((self = [super init])) {
        places = [[NSMutableArray alloc] init];
        temporaryPlaces = [[NSMutableArray alloc] init];
        transitions = [[NSMutableArray alloc] init];
        marking = [[PNMarking alloc] init];
        transitionQueue = [[NSMutableArray alloc] init];
        dependencies=[[NSMutableDictionary alloc] initWithCapacity:4];
        [dependencies setObject:[[NSMutableArray alloc] init] forKey:[NSNumber numberWithInt: EXCLUSION]]; 
        [dependencies setObject:[[NSMutableArray alloc] init] forKey:[NSNumber numberWithInt: WEAK]]; 
        [dependencies setObject:[[NSMutableArray alloc] init] forKey:[NSNumber numberWithInt: STRONG]]; 
        [dependencies setObject:[[NSMutableArray alloc] init] forKey:[NSNumber numberWithInt: REQUIREMENT]]; 
        threadMapping = [[NSMutableDictionary alloc] init]; //<id (NSNumber), color (NSThread)>
    }
    return self;
}

- (void)dealloc {
    [places release];
    [temporaryPlaces release];
    [transitions release];
    [marking release];
    [transitionQueue release];
    [dependencies release];
    [threadMapping release];
    [super dealloc];
}

- (PNPlace *) addPlaceWithName: (NSString *) contextName {
    PNPlace *context = [[PNContextPlace alloc] initWithName:contextName];
    [self addPlace:context];
    return ([context autorelease]);
}

- (PNPlace *) addPlaceWithName: (NSString *) contextName AndCapacity: (int) capacity {
    PNPlace *context = [[PNContextPlace alloc] initWithName:contextName AndCapacity:capacity];
    [self addPlace:context];
    return ([context autorelease]);
}

- (void)addPlace:(PNPlace *)aContext {
    NSParameterAssert(aContext);
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    //create the temporaryplaces
    NSString * contextName = [aContext label];
    NSMutableString *name = [@"PR." mutableCopy];
    [name appendString:contextName];
    PNPlace *pr = [[PNTemporaryPlace alloc] initWithName:[NSString stringWithFormat:name]];
    [name setString:@"PRN."];
    [name appendString:contextName];
    PNPlace *prn = [[PNTemporaryPlace alloc] initWithName:[NSString stringWithFormat:name]];
    [name setString:@"NEG."];
    [name appendString:contextName];
    PNPlace *neg = [[PNTemporaryPlace alloc] initWithName:[NSString stringWithFormat:name]];
    //create the external transitions
    [name setString:@"req."];
    [name appendString:contextName];
    PNTransition *reqact = [[PNExternalTransition alloc] initWithName:[NSString stringWithString:name]];
    [name setString:@"reqn."];
    [name appendString:contextName];
    PNTransition *reqdeac = [[PNExternalTransition alloc] initWithName:[NSString stringWithString:name]];
    // create the internal transitions
    [name setString:@"act."];
    [name appendString:contextName];
    PNTransition *act = [[PNInternalTransition alloc] initWithName:[NSString stringWithString:name]];
    [name setString:@"deac."];
    [name appendString:contextName];
    PNTransition *deac = [[PNInternalTransition alloc] initWithName:[NSString stringWithString:name]];
    [name setString:@"cl."];
    [name appendString:contextName];
    PNTransition *cl = [[PNInternalTransition alloc] initWithName:[NSString stringWithString:name] andPriority:CLEANING];
    // connecting places and transitions   
    [reqact addOutput:n toPlace:pr];
    [act addInput:n fromPlace:pr];
    [act addOutput:n toPlace:aContext];
    [reqdeac addOutput:n toPlace:prn];
    [deac addInput:n fromPlace:aContext];
    [deac addInput:n fromPlace:prn];
    [deac addOutput:n toPlace:neg];
    [cl addInput:n fromPlace:neg];
    //add contexts to the array of contexts
    [places addObject:aContext];
    [temporaryPlaces addObject:pr];
    [temporaryPlaces addObject:prn];
    [temporaryPlaces addObject:neg];
    //add transitions
    [transitions addObject:reqact];
    [transitions addObject:act];
    [transitions addObject:reqdeac];
    [transitions addObject:deac];
    [transitions addObject:cl];
    //release created objects
    [pr release];
    [prn release];
    [neg release];
    [reqact release];
    [act release];
    [reqdeac release];
    [deac release];
    [cl release];
    [name release];
    [n release];    
}

- (void)removePlace:(PNPlace *)aPlace {
    NSParameterAssert(aPlace);
    [places removeObject:aPlace];
    for(PNPlace *p in [self temporaryPlaces]) {
        if([[p label] hasSuffix:[aPlace label]])
            [temporaryPlaces removeObject:p];
    }
    for(PNTransition *t in transitions) {
        if([[t label] hasSuffix:[aPlace label]]) 
            [transitions removeObject:t];
    }
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

-(void) addInternalTransitionToQueue: (PNInternalTransition *) iTransition {
    if([transitionQueue containsObject:iTransition]){
        //If the transition is already in the queue do nothing
    } else if([iTransition priority] == CLEANING)
        [transitionQueue addObject:iTransition];
    else if([transitionQueue count] == 0) {
        [transitionQueue addObject:iTransition];
    } else if([transitionQueue count] == 1) {
        PNInternalTransition *t = [transitionQueue objectAtIndex:0];
        if([t priority] == CLEANING) 
            [transitionQueue insertObject:iTransition atIndex:0]; 
        else 
            [transitionQueue addObject:iTransition];
    } else {
        for(int i=[transitionQueue count]; i>0; i--) {
            PNInternalTransition *t = [transitionQueue objectAtIndex:i-1];
            if([t priority] == INTERNAL) {
                [transitionQueue insertObject:iTransition atIndex:i]; 
                break;
            } else if(i-1 == 0) {
                [transitionQueue insertObject:iTransition atIndex:0]; 
                break;
            }
        }
    }
}


-(BOOL) isStable {
    for(PNPlace *p in [[PNManager sharedManager] temporaryPlaces]) {
        if ([p isActive]) {
            return NO;
        }
    }
    return YES;
}

-(NSArray *) getInputsForPlace:(PNPlace *)place {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *t in transitions) {
        if([[t outputs] objectForKey:place])
            [result addObject:t];
    }
    return ([result autorelease]);
}

- (NSArray *) getOutputsForPlace:(PNPlace *)place {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *t in transitions) {
        if([[t inputs] objectForKey:place])
            [result addObject:t];
    }
    return ([result autorelease]);    
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@CoPN \r"];
    for(PNTransition *t in transitions) {
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