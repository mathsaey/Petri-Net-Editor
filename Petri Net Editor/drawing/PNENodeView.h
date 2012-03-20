//
//  PNENodeView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "../kernel/PNNode.h"
#import "../PNEConstants.h"
#import "PNEViewElement.h"

@interface PNENodeView : PNEViewElement {
    BOOL isMarked;
        
    CGFloat xOrig; //X value of the top-left corner of the square
    CGFloat yOrig; //Y value of the top-left corner of the square
    
    NSString *label;
    
    CGFloat dimensions; //Dimension of the square
}

@property (readonly) BOOL isMarked;
@property (readonly) CGFloat xOrig;
@property (readonly) CGFloat yOrig;
@property (readonly) CGFloat dimensions;

- (void) dimNode;
- (void) drawLabel;
- (void) highlightNode;
- (void) toggleHighlight;
- (void) drawNode: (CGPoint) origin;

//Returns the middle point of an edge of the square
- (CGPoint) getTopEdge;
- (CGPoint) getLeftEdge;
- (CGPoint) getRightEdge;
- (CGPoint) getBottomEdge;

//Returns the corners of the square
- (CGPoint) getLeftTopPoint;
- (CGPoint) getRightTopPoint;
- (CGPoint) getLeftBottomPoint;
- (CGPoint) getRightBottomPoint;

//Check how a given node is positioned in relation to the object
- (BOOL) isLower: (PNENodeView*) node;
- (BOOL) isHigher: (PNENodeView*) node;
- (BOOL) isLeft: (PNENodeView*) node;
- (BOOL) isRight: (PNENodeView*) node;
- (BOOL) isLeftAndLower: (PNENodeView*) node;
- (BOOL) isRightAndLower: (PNENodeView*) node;
- (BOOL) isLeftAndHigher: (PNENodeView*) node;
- (BOOL) isRightAndHigher: (PNENodeView*) node;
- (BOOL) doesOverlap: (PNENodeView*) node;

- (void) multiplyDimension: (CGFloat) multiplier;

@end
