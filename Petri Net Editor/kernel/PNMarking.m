//
//  PNMarking.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 11/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNMarking.h"
#import "PNPlace.h"

@implementation PNMarking

@synthesize activeContexts;
@synthesize systemMarking;

-(id) init {
    if((self = [super init])) {
        activeContexts = [[NSMutableArray alloc] init];
        systemMarking = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc {
    [activeContexts release];
    [systemMarking release];
    [super dealloc];
}

- (void) addActiveContextToMarking: (PNPlace *) context {
    NSParameterAssert(context);
    [activeContexts addObject:context];
}

- (void) removeActiveContextFromMarking: (PNPlace *) context {
    [activeContexts removeObject:context];
}

-(void) clean {
    [activeContexts removeAllObjects];
}

- (void) updateSystemState {
    [systemMarking removeAllObjects];
    [systemMarking addObjectsFromArray:activeContexts];
}

- (void) revertOperation {
    [activeContexts removeAllObjects];
    [activeContexts addObjectsFromArray:systemMarking];
     
}

-(NSString *) description {
    NSMutableString *desc = [[NSMutableString alloc] init];
    for(PNPlace *c in systemMarking) {
        [desc appendString:[c description]];
    }
    return [desc autorelease];
}
@end
