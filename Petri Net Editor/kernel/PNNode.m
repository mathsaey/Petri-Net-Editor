//
//  Node.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 06/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNNode.h"


@implementation PNNode

@synthesize label, view;

- (id) init {
    return ([super init]);
}

- (id) initWithName: (NSString *) newName {
    if((self = [super init])) {
        label = newName;
    }
    return self;
}

@end
