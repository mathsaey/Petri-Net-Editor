//
//  PNToken.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 08/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PNElement.h"

/*
 * Token elements go into places, a token in a place is represented by its multiplicity
 */

@interface PNToken : PNElement {
@public	
    int value;
    UIColor *color;
}

@property(nonatomic, readwrite) int value;
@property(nonatomic, readwrite, copy) UIColor *color;

@end
