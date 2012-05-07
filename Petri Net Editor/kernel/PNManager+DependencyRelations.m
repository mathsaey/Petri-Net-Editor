//
//  PNManager+DependencyRelations.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 21/10/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNManager.h"
#import "PNTransition.h"
#import "PNInternalTransition.h"
#import "PNPlace.h"
#import "PNMarking.h"
#import "NSDictionary+SetEquals.h"

@implementation PNManager (DependencyRelations)

- (void) registerDependency:(SCDependencyRelations)type BetweenSource:(PNPlace *)source AndTarget:(PNPlace *)target {
    NSArray *newDep = [[NSArray alloc] initWithObjects:source, target, nil];
    NSNumber *n = [NSNumber numberWithInt:type];
    NSMutableArray *dependent = [[self dependencies] objectForKey:n];
    [dependent addObject:newDep];
    switch (type) {
        case EXCLUSION:
            [self checkExclusionConstrains];
            break;
        case WEAK:
            [self checkWeakInclusionConstrains];
            break;    
        case STRONG:
            [self checkStrongInclusionConstrains];
            break; 
        case REQUIREMENT:
            [self checkRequirementConstrains];
            break;
        default:
            break;
    }
    [self trimRepeatedTransitions];
    [newDep release];
}

- (void) removeDependency:(SCDependencyRelations) type BetweenSource:(PNPlace *)source AndTarget:(PNPlace *)target {
    NSMutableArray *dependent = [[self dependencies] objectForKey:[NSNumber numberWithInt: type]];
    for(NSArray *arr in dependent){
        if (type == EXCLUSION) {
            if ([arr containsObject:source] && [arr containsObject:target]) {
                [dependent removeObject:arr];
                break;
            }
        } else if([[arr objectAtIndex:0] isEqual:source] && [[arr objectAtIndex:1] isEqual:target]) {
            [dependent removeObject:arr];
            break;
        }
    }
}

- (void)addExclusionBetween:(PNPlace *)source and:(PNPlace *) target {
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    NSMutableString *name1 = [[NSMutableString alloc] initWithString:@"act."];
    [name1 appendString:[source label]];
    NSMutableString *name2 = [[NSMutableString alloc] initWithString:@"act."];
    [name2 appendString:[target label]];
    
    for(PNTransition *t in transitions) {
        if ([[t label] isEqualToString:[NSString stringWithFormat:name1]]) {
            if (![[t inhibitorInputs] containsObject:target]) {
                [t addInput:i fromPlace:target];
            }
        } else if([[t label] isEqualToString:[NSString stringWithFormat:name2]]) {
            if (![[t inhibitorInputs] containsObject:source]) 
                [t addInput:i fromPlace:source];
        }
    }
    [i release];
    [name1 release];
    [name2 release];
    [self registerDependency:EXCLUSION BetweenSource:source AndTarget:target];
}

- (void) addWeakInclusionFrom:(PNPlace *)source To:(PNPlace *)target {
    NSMutableString *actS = [[NSMutableString alloc] initWithString:@"act."];
    NSMutableString *deacS = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    
    [actS appendString: [source label]];
    [deacS appendString: [source label]];
    
    for(PNTransition *t in transitions) {
        if ([[t label] isEqualToString:[NSString stringWithFormat:actS]]) {
            if(![[[t outputs] allKeys] containsObject:target])
                [t addOutput:n toPlace:[target getPrepareForActivation]];
        } else if([[t label] isEqualToString:[NSString stringWithFormat:deacS]]) {
            if (![[[t outputs] allKeys] containsObject:target]) {
                [t addOutput:n toPlace:[target getPrepareForDeactivation]];
                [t addOutput:n toPlace:target];
                [t addInput:n fromPlace:target]; 
            }
        }
    }
    
    PNInternalTransition *deacSource = [[PNInternalTransition alloc] initWithName:[NSString stringWithFormat:deacS]];
    [deacSource addInput:n fromPlace:source];
    [deacSource addInput:n fromPlace:[source getPrepareForDeactivation]];
    [deacSource addInput:i fromPlace:target];
    
    [self addTransition:deacSource];
    
    //releasing objects
    [deacSource release];
    [actS release];
    [deacS release];
    [i release];
    [n release];    
    
    [self registerDependency:WEAK BetweenSource:source AndTarget:target];
}

- (void) addStrongInclusionFrom:(PNPlace *)source To:(PNPlace *)target {
    NSMutableString *deacS = [[NSMutableString alloc] initWithString:@"deac."];
    NSMutableString *deacT = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    
    [deacS appendString: [source label]];
    [deacT appendString: [target label]];
    
    PNInternalTransition *deacSource = [[PNInternalTransition alloc] initWithName:[NSString stringWithFormat:deacS]];
    [deacSource addInput:n fromPlace:[source getDeactivationFlag]];
    [deacSource addInput:n fromPlace:[source getPrepareForDeactivation]];
    [deacSource addOutput:n toPlace:[source getDeactivationFlag]];
    PNInternalTransition *deacTarget = [[PNInternalTransition alloc] initWithName:[NSString stringWithFormat:deacT]];
    [deacTarget addInput:n fromPlace:target];
    [deacTarget addInput:n fromPlace:[target getPrepareForDeactivation]];
    [deacTarget addInput:i fromPlace:source];
    PNInternalTransition *deacTarget2 = [[PNInternalTransition alloc] initWithName:[NSString stringWithFormat:deacT]];
    [deacTarget2 addInput:n fromPlace:[target getDeactivationFlag]];
    [deacTarget2 addInput:n fromPlace:[target getPrepareForDeactivation]];
    [deacTarget2 addOutput:n toPlace:[target getDeactivationFlag]];
    [self addTransition:deacSource];
    [self addTransition:deacTarget];
    [self addTransition:deacTarget2];
    
    //every deactivation of the source deactivates the target
    for (PNTransition *t in [self getOutputsForPlace:source]) {
        if([[t label] isEqualToString:[NSString stringWithFormat:deacS]] && [[t outputs] objectForKey:[source getDeactivationFlag]] != nil)
            [t addInput:i fromPlace:[source getDeactivationFlag]];
    }
    //every deactivation of the target deactivates the source
    for (PNTransition *t in [self getOutputsForPlace:target]) {
        if([[t label] isEqualToString:[NSString stringWithFormat:deacT]] && [[t inputs] objectForKey:source] == nil) {
            [t addInput:i fromPlace:[target getDeactivationFlag]];
            [t addInput:n fromPlace:source];
            [t addOutput:n toPlace:source];
        }
    }
    
    [self registerDependency:STRONG BetweenSource:source AndTarget:target];
    
    //releasing objects
    [deacSource release];
    [deacTarget release];
    [deacTarget2 release];
    [deacS release];
    [deacT release];
    [i release];
    [n release];    
}

- (void) addRequirementTo:(PNPlace *)source Of:(PNPlace *)target {
    NSMutableString *actS = [[NSMutableString alloc] initWithString:@"act."];
    NSMutableString *deacS = [[NSMutableString alloc] initWithString:@"deac."];
    NSMutableString *deacT = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    
    [actS appendString: [source label]];
    [deacS appendString: [source label]];
    [deacT appendString: [target label]];
    
    //deactivate target when source is inactive
    PNInternalTransition *deacTarget = [[PNInternalTransition alloc] initWithName:[NSString stringWithFormat:deacT]];
    [deacTarget addInput:n fromPlace:target];
    [deacTarget addInput:n fromPlace:[target getPrepareForDeactivation]];
    [deacTarget addInput:i fromPlace:source];
    
    PNInternalTransition *deacSource = [[PNInternalTransition alloc] initWithName:[NSString stringWithFormat:deacS]];
    [deacSource addInput:i fromPlace:target];
    [deacSource addInput:n fromPlace:source];
    [deacSource addInput:n fromPlace:[source getPrepareForDeactivation]];
    [deacSource addInput:n fromPlace:[source getDeactivationFlag]];
    [deacSource addOutput:n toPlace:[source getDeactivationFlag]];
    [deacSource addOutput:n toPlace:[source getPrepareForDeactivation]];
    
    PNInternalTransition *deacdeacSource2 = [[PNInternalTransition alloc] initWithName:[NSString stringWithFormat:deacS]];
    [deacdeacSource2 addInput:n fromPlace:[source getDeactivationFlag]];
    [deacdeacSource2 addInput:n fromPlace:[source getPrepareForDeactivation]];
    [deacdeacSource2 addOutput:n toPlace:[source getDeactivationFlag]];
    
    [self addTransition:deacSource];
    [self addTransition:deacTarget];
    [self addTransition:deacdeacSource2];
    //deactivate target extra conditions (deactivate when source is active)
    for(PNTransition *t in [self getInputsForPlace:source]) {
        if ([[t label] isEqualToString:[NSString stringWithFormat:actS]]) {
            [t addOutput:n toPlace:target];
            [t addInput:n fromPlace:target];
        } 
    }
    //activate source iff target is active
    for(PNTransition *t in [self getOutputsForPlace:target]) {
        if ([[t label] isEqualToString:[NSString stringWithFormat:deacT]]) {
            if ([[t inputs] objectForKey:source] == nil) {
                [t addOutput:n toPlace:source];
                [t addInput:n fromPlace:source];
            }
        } 
    }
    //deactivate source extra conditions
    for(PNTransition *t in [self getOutputsForPlace:source]){
        if([[t label] isEqualToString:[NSString stringWithFormat:deacS]]) {
            if([[t inputs] objectForKey:target] != nil)
                [t addOutput:n toPlace:[source getPrepareForDeactivation]];
            else if([[t inputs] objectForKey:[source getDeactivationFlag]] == nil) {
                [t addOutput:n toPlace:[source getPrepareForDeactivation]];
                [t addInput:i fromPlace:[source getDeactivationFlag]];
            }
        }
    }
    
    [self registerDependency:REQUIREMENT BetweenSource:source AndTarget:target];
    
    //releasing objects
    [deacSource release];
    [deacTarget release];
    [deacdeacSource2 release];
    [actS release];
    [deacS release];
    [deacT release];
    [i release];
    [n release];    
}

- (void) trimRepeatedTransitions {
    PNTransition *t1;
    PNTransition *t2;
    for(int i=0; i < [transitions count]; i++) {
        for(int j=0; j < [transitions count]; j++) {
            t1 = [transitions objectAtIndex:i];
            t2 = [transitions objectAtIndex:j];
            if(i != j && [[t1 label] isEqualToString:[t2 label]]) {
                if([[t1 inputs] isSetEqualsTo:[t2 inputs]] && [[t1 outputs] isSetEqualsTo:[t2 outputs]]) 
                    [self removeTransition:t2];
            }
        }
    }
}

/**
 * Returns YES if the given context is already part of a composition relation
 */
- (BOOL) isComposed:(PNPlace *)context {
    for(PNPlace *p in [self places]) {
        if([[[p label] componentsSeparatedByString:@"+"] count] > 1)
            if([[p label] hasPrefix:[context label]] || [[p label] hasSuffix:[context label]])
                return YES;
    }
    return NO;
}

- (void) checkExclusionConstrains {
    PNArcInscription *i = [[PNArcInscription alloc] initWithType:INHIBITOR];
    for(NSArray *arr in [[self dependencies] objectForKey:[NSNumber numberWithInt:EXCLUSION]]) {
        PNPlace *source = [arr objectAtIndex:0];
        PNPlace *target = [arr objectAtIndex:1];
        //all source inputs most have an inhibitor from the target
        for (PNTransition *t in [self getInputsForPlace:source])
            if ([[t inputs] objectForKey:source] == nil)
                [t addInput:i fromPlace:target];
        //all target inputs most have an inhibitor from the source
        for (PNTransition *t in [self getInputsForPlace:target])
            if ([[t inputs] objectForKey:target] == nil)
                [t addInput:i fromPlace:source];
    }
    [i release];
}

- (void) checkWeakInclusionConstrains {
    PNArcInscription *i = [[PNArcInscription alloc] initWithType:INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType:NORMAL];
    NSMutableString *deac = [[NSMutableString alloc] initWithString:@"deac."];
    for(NSArray *arr in [[self dependencies] objectForKey:[NSNumber numberWithInt:WEAK]]) {
        PNPlace *source = [arr objectAtIndex:0];
        PNPlace *target = [arr objectAtIndex:1];
        
        //every activation input of the source activates the target
        for (PNTransition *t in [self getInputsForPlace:source]) {
            if([[t label] hasPrefix:@"act."])
                [t addOutput:n toPlace:[target getPrepareForActivation]];
        }
        //every deactivation of the source deactivates the target
        [deac setString:@"deac."];
        [deac appendString:[source label]];
        for (PNTransition *t in [self getOutputsForPlace:source]) {
            if([[t label] isEqualToString:[NSString stringWithFormat:deac]] && [[t inhibitorInputs] count] == 0) 
                [t addOutput:n toPlace:[target getPrepareForDeactivation]];
        }
    }
    [i release];
    [n release];
    [deac release];
}

- (void) checkStrongInclusionConstrains {
    PNArcInscription *i = [[PNArcInscription alloc] initWithType:INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType:NORMAL];
    NSMutableString *deac = [[NSMutableString alloc] initWithString:@"deac."];
    for(NSArray *arr in [[self dependencies] objectForKey:[NSNumber numberWithInt:STRONG]]) {
        PNPlace *source = [arr objectAtIndex:0];
        PNPlace *target = [arr objectAtIndex:1];
        //every activation input of the source activates the target
        for(PNTransition *t in [self getInputsForPlace:source]) {
            if([[t label] hasPrefix:@"act."])
                [t addOutput:n toPlace:[target getPrepareForActivation]];
        }
        //every deactivation of the source deactivates the target
        [deac setString:@"deac."];
        [deac appendString:[source label]];
        for (PNTransition *t in [self getOutputsForPlace:source]) {
            if([[t label] isEqualToString:[NSString stringWithFormat:deac]]) 
                [t addOutput:n toPlace:[target getPrepareForDeactivation]];
        }
        //every deactivation of the target deactivates the source
        [deac setString:@"deac."];
        [deac appendString:[target label]];
        for (PNTransition *t in [self getOutputsForPlace:target]) {
            PNArcInscription *ai = [[t inputs] objectForKey:source];
            if([[t label] isEqualToString:[NSString stringWithFormat:deac]] && [ai type] != INHIBITOR)
                [t addOutput:n toPlace:[source getPrepareForDeactivation]];
        }
    }
    [i release];
    [n release];
    [deac release];
}

- (void) checkRequirementConstrains {
    PNArcInscription *n = [[PNArcInscription alloc] initWithType:NORMAL];
    NSMutableString *deac = [[NSMutableString alloc] init];
    for(NSArray *arr in [[self dependencies] objectForKey:[NSNumber numberWithInt:REQUIREMENT]]) {
        PNPlace *source = [arr objectAtIndex:0];
        PNPlace *target = [arr objectAtIndex:1];
        //every deactivation of the target deactivates the source
        [deac setString:@"deac."];
        [deac appendString:[target label]];
        for (PNTransition *t in [self getOutputsForPlace:target]) {
            PNArcInscription *ai = [[t inputs] objectForKey:source];
            if([[t label] isEqualToString:[NSString stringWithFormat:deac]]) {
                if([[t inputs] objectForKey:target] != nil && [[t inputs] objectForKey:source] == nil)
                    [t addOutput:n toPlace:[source getPrepareForDeactivation]];    
            }   
        }
    }
    [n release];
    [deac release];
}

@end