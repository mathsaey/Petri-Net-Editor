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
    
    PNENodeView *fromNode;
    PNENodeView *toNode;
}

@property (retain, readwrite) PNENodeView *fromNode, *toNode;

- (void) reDrawArc;
- (void) drawArc: (PNENodeView*) fromNode transition: (PNENodeView*) toNode;

@end




/*
Lijn tekenen loodrecht op pad via transformatie???
 
 
 
*/
