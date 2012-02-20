//
//  PNENodeView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEViewElement.h"

@interface PNENodeView : PNEViewElement {
    CGFloat xOrig; //X value of the top-left corner of the square
    CGFloat yOrig; //Y value of the top-left corner of the square
    
    CGFloat dimensions; //Dimension of the square
}

@property (readonly) CGFloat xOrig;
@property (readonly) CGFloat yOrig;
@property (readonly) CGFloat dimensions;


- (void) drawLabel;
- (void) drawNode: (CGFloat) x yVal: (CGFloat) y;

//Returns the middle point of an edge of the square
- (CGPoint) getTopEdge;
- (CGPoint) getLeftEdge;
- (CGPoint) getRightEdge;
- (CGPoint) getBottomEdge;

//Check how a given node is positioned in relation to the object
- (BOOL) isLower: (PNENodeView*) node;
- (BOOL) isHigher: (PNENodeView*) node;
- (BOOL) isLeft: (PNENodeView*) node;
- (BOOL) isRight: (PNENodeView*) node;


- (id) initWithElement:(id) pnElement;
- (void) multiplyDimension: (CGFloat) multiplier;

@end
