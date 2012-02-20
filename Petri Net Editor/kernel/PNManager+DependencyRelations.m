//
//  PNManager+DependencyRelations.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 21/10/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNManager.h"
#import "PNTransition.h"
#import "PNPlace.h"
#import "PNMarking.h"
#import "NSDictionary+SetEquals.h"

@implementation PNManager (DependencyRelations)
- (void)addExclusionFrom:(PNPlace *)source to:(PNPlace *) target {
    NSMutableString *activate = [[NSMutableString alloc] initWithString:@"act."];
    NSMutableString *deactivate = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    
    [activate appendString:[source label]];
    PNTransition *tActivateInhibitorSource = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [deactivate appendString:[source label]];
    PNTransition *tDeactivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    [activate setString:@"act."];
    [activate appendString:[target label]];
    PNTransition *tActivateInhibitorTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [deactivate setString:@"deac."];
    [deactivate appendString:[target label]];
    PNTransition *tDeactivateNormalTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    // Adding the arcs between places and transitions
    [self composeTransition:tActivateInhibitorSource with:i fromInput:target];
    [self composeTransition:tActivateInhibitorSource with:n toOutput:source];
    [self composeTransition:tActivateInhibitorTarget with:i fromInput:source];
    [self composeTransition:tActivateInhibitorTarget with:n toOutput:target];
    [self composeTransition:tDeactivateNormalSource with:n fromInput:source];
    [self composeTransition:tDeactivateNormalTarget with:n fromInput:target];
    //releasing objects
    [activate release];
    [deactivate release];
    [tActivateInhibitorSource release];
    [tDeactivateNormalSource release];
    [tActivateInhibitorTarget release];
    [tDeactivateNormalTarget release]; 
    [i release];
    [n release];
}

- (void)addWeakInclusionFrom:(PNPlace *) source to:(PNPlace *) target {
    NSMutableString *activate = [[NSMutableString alloc] initWithString:@"act."];
    NSMutableString *deactivate = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    
    [deactivate appendString:[source label]];
    PNTransition *tDeactivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    PNTransition *tDeactivateInhibitorSource = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    [activate appendString: [source label]];
    PNTransition *tActivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [deactivate setString:@"deac."];
    [deactivate appendString: [target label]];
    PNTransition *tDeactivateNormalTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    [activate setString:@"act."];
    [activate appendString: [target label]];
    PNTransition *tActivateNormalTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [self composeTransition:tDeactivateNormalSource with:n fromInput:target];
    [self composeTransition:tDeactivateNormalSource with:n fromInput:source];
    [self composeTransition:tDeactivateNormalTarget with:n fromInput:target];
    [self composeTransition:tActivateNormalSource with:n toOutput:target];
    [self composeTransition:tActivateNormalSource with:n toOutput:source];
    [self composeTransition:tDeactivateInhibitorSource with:n fromInput:source];
    [self composeTransition:tDeactivateInhibitorSource with:i fromInput:target];
    [self composeTransition:tActivateNormalTarget with:n toOutput:target];
    //releasing objects
    [activate release];
    [deactivate release];
    [tDeactivateNormalSource release];
    [tDeactivateInhibitorSource release];
    [tActivateNormalSource release];
    [tDeactivateNormalTarget release];
    [tActivateNormalTarget release];
    [i release];
    [n release];    
}

- (void) addStrongInclusionFrom:(PNPlace *)source to:(PNPlace *)target {
    NSMutableString *activate = [[NSMutableString alloc] initWithString:@"act."];
    NSMutableString *deactivate = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    
    [deactivate appendString: [source label]];
    PNTransition *tDeactivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    [deactivate setString:@"deac."];
    [deactivate appendString: [target label]];
    PNTransition *tDeactivateNormalTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    PNTransition *tDeactivateInhibitorTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    [activate appendString:[target label]];
    PNTransition *tActivateNormalTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [activate setString:@"act."];
    [activate appendString: [source label]];
    PNTransition *tActivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    //Addign arcs between places and transitions
    [self composeTransition:tDeactivateNormalTarget with:n fromInput:target];
    [self composeTransition:tDeactivateNormalTarget with:n fromInput:source];
    [self composeTransition:tActivateNormalSource with:n toOutput:target];
    [self composeTransition:tActivateNormalSource with:n toOutput:source];
    [self composeTransition:tDeactivateNormalSource with:n fromInput:source];
    [self composeTransition:tDeactivateNormalSource with:n fromInput:target];
    [self composeTransition:tDeactivateInhibitorTarget with:i fromInput:source];
    [self composeTransition:tDeactivateInhibitorTarget with:n fromInput:target];
    [self composeTransition:tActivateNormalTarget with:n toOutput:target];
    //releasing objects
    [activate release];
    [deactivate release];
    [tDeactivateNormalSource release];
    [tDeactivateInhibitorTarget release];
    [tActivateNormalSource release];
    [tDeactivateNormalTarget release];
    [tActivateNormalTarget release];
    [i release];
    [n release];   
}

- (void) addRequirementTo:(PNPlace *)source of:(PNPlace *)target {
    NSMutableString *activate = [[NSMutableString alloc] initWithString:@"act."];
    NSMutableString *deactivate = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    
    [activate appendString: [target label]];
    PNTransition *tActivateNormalTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [deactivate appendString: [target label]];
    PNTransition *tDeactivateInhibitorTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    PNTransition *tDeactivateNormalTarget = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    [activate setString:@"act."];
    [activate appendString: [source label]];
    PNTransition *tActivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [deactivate setString:@"deac."];
    [deactivate appendString: [source label]];
    PNTransition *tDeactivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    //Addign arcs between places and transitions
    [self composeTransition:tActivateNormalTarget with:n toOutput:target];
    [self composeTransition:tActivateNormalSource with:n toOutput:source];
    [self composeTransition:tActivateNormalSource with:n toOutput:target];
    [self composeTransition:tDeactivateNormalTarget with:n fromInput:target];
    [self composeTransition:tDeactivateNormalTarget with:n fromInput:source];
    [self composeTransition:tDeactivateInhibitorTarget with:i fromInput:source];
    [self composeTransition:tDeactivateInhibitorTarget with:n fromInput:target];
    [self composeTransition:tDeactivateNormalSource with:n fromInput:source];
    [self composeTransition:tActivateNormalSource with:n fromInput:target];
    //releasing objects
    [activate release];
    [deactivate release];
    [tDeactivateNormalSource release];
    [tDeactivateInhibitorTarget release];
    [tActivateNormalSource release];
    [tDeactivateNormalTarget release];
    [tActivateNormalTarget release];
    [i release];
    [n release];   
}

- (void) addComposedContextsOf:(PNPlace *)source1 and:(PNPlace *) source2 {
    if([self isComposed: source1]) {
        [self compose: source2 withComposition: source1];
    }
    else if ([self isComposed: source2]) {
        [self compose: source1 withComposition: source2];
    }
    else {
        NSMutableString *activate = [[NSMutableString alloc] initWithString:@"act."];
        NSMutableString *deactivate = [[NSMutableString alloc] initWithString:@"deac."];
        PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
        PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
        NSMutableString *comp = [[NSMutableString alloc] initWithString:[source1 label]];
        [comp appendString:@"+"];
        [comp appendString: [source2 label]];
        PNPlace *pComposition = [[PNPlace alloc] initWithName:[NSString stringWithString:comp]];
        [self addPlace:pComposition];
        
        
        [activate appendString: [source1 label]];
        PNTransition *tActivateInhibitorSource1 = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
        PNTransition *tActivateNormalSource1 = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
        [activate setString:@"act."];
        [activate appendString: [source2 label]];
        PNTransition *tActivateInhibitorSource2 = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
        PNTransition *tActivateNormalSource2 = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
        [deactivate appendString: [source1 label]];
        PNTransition *tDeactivateInhibitorSource1 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
        PNTransition *tDeactivateNormalSource1 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
        [deactivate setString:@"deac."];
        [deactivate appendString: [source2 label]];
        PNTransition *tDeactivateInhibitorSource2 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
        PNTransition *tDeactivateNormalSource2 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
        //Addign arcs between places and transitions
        [self composeTransition:tActivateNormalSource1 with:n fromInput:source2];
        [self composeTransition:tActivateNormalSource1 with:n toOutput:source1];
        [self composeTransition:tActivateNormalSource1 with:n toOutput:source2];
        [self composeTransition:tActivateNormalSource1 with:n toOutput:pComposition];
        [self composeTransition:tActivateNormalSource2 with:n fromInput:source1];
        [self composeTransition:tActivateNormalSource2 with:n toOutput:source1];
        [self composeTransition:tActivateNormalSource2 with:n toOutput:source2];
        [self composeTransition:tActivateNormalSource2 with:n toOutput:pComposition];
        [self composeTransition:tDeactivateInhibitorSource1 with:n fromInput:source1];
        [self composeTransition:tDeactivateInhibitorSource1 with:i fromInput:pComposition];
        [self composeTransition:tDeactivateInhibitorSource2 with:n fromInput:source2];
        [self composeTransition:tDeactivateInhibitorSource2 with:i fromInput:pComposition];
        [self composeTransition:tDeactivateNormalSource1 with:n fromInput:source1];
        [self composeTransition:tDeactivateNormalSource1 with:n fromInput:pComposition];
        [self composeTransition:tDeactivateNormalSource2 with:n fromInput:source2];
        [self composeTransition:tDeactivateNormalSource2 with:n fromInput:pComposition];
        [self composeTransition:tActivateInhibitorSource1 with:i fromInput:source2];
        [self composeTransition:tActivateInhibitorSource1 with:n toOutput:source1];
        [self composeTransition:tActivateInhibitorSource2 with:i fromInput:source1];
        [self composeTransition:tActivateInhibitorSource2 with:n toOutput:source2];
        //releasing objects
        [activate release];
        [deactivate release];
        [comp release];
        [tActivateInhibitorSource1 release];
        [tActivateNormalSource1 release];
        [tDeactivateInhibitorSource1 release];
        [tDeactivateNormalSource1 release];
        [tActivateInhibitorSource2 release];
        [tActivateNormalSource2 release];
        [tDeactivateInhibitorSource2 release];
        [tDeactivateNormalSource2 release];
        [pComposition release];
        [i release];
        [n release];   
    }
}

- (void) composeTransition:(PNTransition *) nTransition with:(PNArcInscription *) nArcInscription fromInput:(PNPlace *) nPlace {
    if([[self transitionsWithName:[nTransition label]] count] == 0) {
        [nTransition addInput:nArcInscription fromPlace:nPlace];
        [self addTransition: nTransition];
    } else {
        for(PNTransition *tran in [self transitionsWithName:[nTransition label]]) {
            PNArcInscription *ai = [[tran inputs] objectForKey:nPlace];
            if(ai == nil) {
                [tran addInput:nArcInscription fromPlace:nPlace];
                [self checkRequirementConditionFor: tran from: nPlace];
            } else {
                if([ai type] != [nArcInscription type]) {
                    [nTransition addInput:nArcInscription fromPlace:nPlace];
                    for(PNPlace *p in [[tran inputs] allKeys]) {
                        PNArcInscription *ai2 = [[tran inputs] objectForKey:p];
                        if(![ai isEqual:ai2]) {
                            [nTransition addInput:ai2 fromPlace:p];
                        }
                    }
                    [self addTransition:nTransition];
                }
            }
        }
    }
    [self trimRepeatedTransitions];
}

- (void) composeTransition:(PNTransition *) nTransition with:(PNArcInscription *) nArcInscription toOutput:(PNPlace *) nPlace {
    if([[self transitionsWithName:[nTransition label]] count] == 0) {
        [nTransition addOutput:nArcInscription toPlace:nPlace];
        [self addTransition: nTransition];
    } else {
        for(PNTransition *tran in [self transitionsWithName:[nTransition label]]) {
            if(![[[tran outputs] allKeys] containsObject:nPlace] && [[tran inputs] isEqual:[nTransition inputs]]) 
                [tran addOutput:nArcInscription toPlace:nPlace];
        }
    }
    [self trimRepeatedTransitions];
}

- (void) trimRepeatedTransitions {
    PNTransition *t1;
    PNTransition *t2;
    for(int i=0; i < [transitions count]; i++) {
        for(int j=0; j < [transitions count]; j++) {
            t1 = [transitions objectAtIndex:i];
            t2 = [transitions objectAtIndex:j];
            if(i != j && [[t1 label] isEqualToString:[t2 label]]) {
                if([[t1 inputs] isSetEqualsTo:[t2 inputs]] && [[t1 outputs] isSetEqualsTo:[t2 outputs]]) {
                    [self removeTransition:t2];
                }
            }
        }
    }
}

/**
 * Returns YES if the given place is already part of a composition relation
 */
- (BOOL) isComposed:(PNPlace *)place {
    for(PNPlace *p in places) {
        if([[[p label] componentsSeparatedByString:@"+"] count] > 1)
            if([[p label] hasPrefix:[place label]] || [[p label] hasSuffix:[place label]])
                return YES;
    }
    return NO;
}

- (void) checkRequirementConditionFor: (PNTransition *) nTransition from: (PNPlace *) nPlace {
    NSMutableString *nlabel = [[NSMutableString alloc] initWithString:@"deac."];
    if([[nTransition label] hasPrefix:@"act"]) {
        if([[[nTransition outputs] allKeys] containsObject:nPlace]) {
            for(PNPlace *outp in [[nTransition outputs] allKeys]) {
                if (![[nTransition label] hasSuffix: [outp label]] && ![outp isEqual:nPlace]) {
                    [self addRequirementTransitionsFor: nPlace target: outp];
                }
            }
        }
    }
    else {
        [nlabel setString:@"act."];
        [nlabel appendString: [[[nTransition label] componentsSeparatedByString:@"."] objectAtIndex:1]];
        for(PNTransition *tran in [self transitionsWithName:nlabel]) {
            for(PNPlace *outp in [[tran outputs] allKeys]) {
                if ([[[tran inputs] allKeys] containsObject:outp]) {
                    [self addRequirementTransitionsFor: outp target: nPlace];          
                }
            }
        }
    }
    [nlabel release];
}

- (void) addRequirementTransitionsFor: (PNPlace *) source target: (PNPlace *) target {
    if([[[source label] componentsSeparatedByString:@"+"] count] == 0 && [[[target label] componentsSeparatedByString:@"+"] count] == 0) {
        PNArcInscription *i = [[PNArcInscription alloc] initWithType:INHIBITOR];
        PNArcInscription *n = [[PNArcInscription alloc] initWithType:NORMAL];
        NSMutableString *nlabel = [[NSMutableString alloc] initWithString:@"deac."];
        [nlabel appendString:[source label]];
        PNTransition *t = [[PNTransition alloc] initWithName:[NSString stringWithFormat:nlabel]];
        [t addInput:n fromPlace:target];
        for(PNTransition *tran in [self transitionsWithName:nlabel]) {
            if([[tran inhibitorInputs] count] == 0) {
                for(PNPlace *p in [[tran inputs] allKeys]) {
                    [t addInput:n fromPlace:p];
                }
                [tran addInput:i fromPlace:target];    
                break;
            }                       
        }
        [self addTransition:t];
        [t release];
        [nlabel release];
        [i release];
        [n release];
    }
}

- (void) compose: (PNPlace *) source withComposition: (PNPlace *) composed {
    NSMutableString *activate = [[NSMutableString alloc] initWithString:@"act."];
    NSMutableString *deactivate = [[NSMutableString alloc] initWithString:@"deac."];
    PNArcInscription *i = [[PNArcInscription alloc] initWithType: INHIBITOR];
    PNArcInscription *n = [[PNArcInscription alloc] initWithType: NORMAL];
    PNPlace *otherComposition;
    PNPlace *other;
    NSArray *split;
    for(PNPlace *p in places) {
        split = [[p label] componentsSeparatedByString:@"+"];
        if ([split count] > 1 && [split containsObject:[composed label]]) {
            otherComposition = p;
            other = [self placeWithName:[split objectAtIndex: ((1 + [split indexOfObject:[composed label]])%2)]];
            break;
        }
    }
    
    NSMutableString *comp = [[NSMutableString alloc] initWithString:[composed label]];
    [comp appendString:@"+"];
    [comp appendString: [source label]];
    PNPlace *pComposition = [[PNPlace alloc] initWithName:[NSString stringWithString:comp]];
    [self addPlace:pComposition];
    
    
    [activate appendString: [source label]];
    PNTransition *tActivateInhibitorSource = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    PNTransition *tActivateNormalSource = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [activate setString:@"act."];
    [activate appendString: [composed label]];
    PNTransition *tActivateNormalSource2 = [[PNTransition alloc] initWithName: [NSString stringWithString:activate]];
    [deactivate appendString: [source label]];
    PNTransition *tDeactivateInhibitorSource1 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    PNTransition *tDeactivateNormalSource1 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    [deactivate setString:@"deac."];
    [deactivate appendString: [composed label]];
    PNTransition *tDeactivateInhibitorSource2 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    PNTransition *tDeactivateNormalSource2 = [[PNTransition alloc] initWithName: [NSString stringWithString:deactivate]];
    //Addign arcs between places and transitions for the new composition relation
    [self composeTransition:tActivateNormalSource with:n fromInput:composed];
    [self composeTransition:tActivateNormalSource with:n toOutput:source];
    [self composeTransition:tActivateNormalSource with:n toOutput:composed];
    [self composeTransition:tActivateNormalSource with:n toOutput:pComposition];
    [tActivateNormalSource2 addInput:n fromPlace:source];
    [tActivateNormalSource2 addOutput:n toPlace:source];
    [tActivateNormalSource2 addOutput:n toPlace:composed];
    [tActivateNormalSource2 addOutput:n toPlace:pComposition];
    [tActivateNormalSource2 addInput:i fromPlace:other];
    [self addTransition:tActivateNormalSource2];
    [self composeTransition:tDeactivateInhibitorSource1 with:n fromInput:source];
    [self composeTransition:tDeactivateInhibitorSource1 with:i fromInput:pComposition];
    [self composeTransition:tDeactivateNormalSource1 with:n fromInput:source];
    [self composeTransition:tDeactivateNormalSource1 with:n fromInput:pComposition];
    [self composeTransition:tActivateInhibitorSource with:i fromInput:composed];
    [self composeTransition:tActivateInhibitorSource with:n toOutput:source];
    //Addign arcs between places and transitions for the connection between the two composition relations
    for(PNTransition *tran in [self transitionsWithName:[NSString stringWithString:deactivate]]) {
        [tran addInput:n fromPlace:pComposition];
    }
    [activate setString:@"act."];
    [activate appendString:[composed label]];
    for(PNTransition *tran2 in [self transitionsWithName:[NSString stringWithString:activate]]){
        if([[[tran2 outputs] allKeys] containsObject:otherComposition] || [[tran2 outputs] objectForKey:other] == INHIBITOR) {
            [tran2 addInput:i fromPlace:source];
        }
    }
    [tDeactivateNormalSource2 addInput:i fromPlace:pComposition];
    [tDeactivateNormalSource2 addInput:n fromPlace:composed];
    [tDeactivateNormalSource2 addInput:n fromPlace:otherComposition];
    [self addTransition:tDeactivateNormalSource2];
    [tDeactivateInhibitorSource2 addInput:i fromPlace:pComposition];
    [tDeactivateInhibitorSource2 addInput:i fromPlace:otherComposition];
    [tDeactivateInhibitorSource2 addInput:n fromPlace:composed];
    [self addTransition:tDeactivateInhibitorSource2];
    //releasing objects
    [activate release];
    [deactivate release];
    [comp release];
    [tActivateInhibitorSource release];
    [tActivateNormalSource release];
    [tDeactivateInhibitorSource1 release];
    [tDeactivateNormalSource1 release];
    [tActivateNormalSource2 release];
    [tDeactivateInhibitorSource2 release];
    [tDeactivateNormalSource2 release];
    [pComposition release];
    [i release];
    [n release];   
}
@end
