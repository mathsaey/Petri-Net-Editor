//
//  Node.h
//  PetriNetKernel
//
//  Created by NicolasCardozo on 06/05/11.
//  Copyright 2011 Université catolique de Louvain. All rights reserved.
//

#import "PNElement.h"
@class PNENodeView;

/*
 * Class to represent places and transition with their label
 * There can more than one node (transition) with the same label
 */

@interface PNNode : PNElement {
    PNENodeView *view;
	NSString *label;
}

/**
 * Non unique label with which elements are tagged
 */
@property(nonatomic, readwrite, copy) NSString * label;
@property(atomic, readwrite, weak) PNENodeView *view;

- (id) initWithName: (NSString *) newName;

@end
