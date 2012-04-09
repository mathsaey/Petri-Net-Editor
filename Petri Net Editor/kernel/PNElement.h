//
//  PNElement.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 19/09/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PNElement : NSObject {
@public 
    NSValue *code;
}

@property(nonatomic,readonly) NSValue *code;

@end
