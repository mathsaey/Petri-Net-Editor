//
//  PNElement.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 19/09/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNElement.h"


@implementation PNElement

@synthesize code;

- (id)init {
    self = [super init];
    if (self) {
        code = [NSNumber valueWithNonretainedObject:self];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
