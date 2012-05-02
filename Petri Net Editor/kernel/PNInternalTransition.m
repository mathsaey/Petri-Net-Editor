//
//  PNInternalTransition.m
//  context
//
//  Created by NicolasCardozo on 18/03/12.
//  Copyright 2012 Université catolique de Louvain. All rights reserved.
//

#import "PNInternalTransition.h"
#import "PNManager.h"

@implementation PNInternalTransition

- (id)init {
    self = [super init];
    [self setPriority:INTERNAL];
    return self;
}

- (id) initWithName:(NSString *)newName {
    self = [super initWithName:newName];
    [self setPriority:INTERNAL];
    return self;
}


- (void)dealloc {
    [super dealloc];
}

-(BOOL) checkEnabledWithColor:(NSNumber *)color {
    [super checkEnabledWithColor:color];
    if(enabled)
        [[PNManager sharedManager] addInternalTransitionToQueue: self];
    return enabled;
}
@end
