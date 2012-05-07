//
//  NSDictionary+SetEquals.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 26/09/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (SetEquals) 

- (BOOL) isSetEqualsTo: (NSDictionary *) otherDictionary; 

@end
