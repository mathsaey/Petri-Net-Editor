//
//  NSDictionary+SetEquals.m
//  PetriNetKernel
//
//  Created by NicolasCardozo on 26/09/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "NSDictionary+SetEquals.h"


@implementation NSDictionary (SetEquals)

- (BOOL) isSetEqualsTo: (NSDictionary *) otherDictionary {
    if ([otherDictionary count] != [self count]) {
        return NO;
    } else {
        BOOL equals = YES;
        NSArray *keys = [self allKeys];
        for(int i=0; i < [keys count] && equals; i++) {
            if(![[otherDictionary allKeys] containsObject: [keys objectAtIndex:i]]) 
                equals = NO;
            else if (![[self objectForKey:[keys objectAtIndex:i]] isEqual:[otherDictionary objectForKey:[keys objectAtIndex:i]]]) 
                equals = NO;
        }
        return equals;
    }
}

@end
