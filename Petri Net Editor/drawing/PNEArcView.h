//
//  PNEArcView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "../kernel/PNArcInscription.h"
#import "../PNEConstants.h"

#import "PNEViewElement.h"
#import "PNENodeView.h"


@interface PNEArcView : PNEViewElement {
    BOOL isInhibitor;
    int weight;
    
    PNENodeView *fromNode;
    PNENodeView *toNode;
    
    NSMutableArray *touchViews;
}

- (void) drawArc;
- (void) setNodes: (PNENodeView*) newFromNode toNode: (PNENodeView*) newToNode;

@end
