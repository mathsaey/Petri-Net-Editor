//
//  PNEView+PNEGraphDrawingCategory.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 11/04/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEView+PNEGraphDrawingCategory.h"

@implementation PNEView (GraphDrawing)

- (void) calculatePositions {
    CGFloat horizontalDistance = 100;
    CGPoint currentLocation = CGPointMake(START_OFFSET_X, START_OFFSET_Y);
    
    for (PNENodeView* node in nodes) {
        [node drawNode:currentLocation];
        
        if (currentLocation.x >= self.bounds.size.width) {
            currentLocation.x = self.bounds.origin.x + horizontalDistance;
            currentLocation.y += 100;
        }
        else currentLocation.x += horizontalDistance;
        
        //Add touch responders
        [node createTouchView:CGRectMake(node.xOrig, node.yOrig, node.dimensions, node.dimensions)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:node action:@selector(handleTapGesture:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:node action:@selector(handlePanGesture:)];
        [node addTouchResponder:tap];
        [node addTouchResponder:pan];
    }
    
}

- (void)drawRect:(CGRect)rect {
    static bool first = true;
    
    if (first && [nodes count] != 0) {
        [self calculatePositions];
        first = false;}
    else {
    
    for (PNENodeView* node in nodes) {
        [node drawNode:CGPointMake(node.xOrig, node.yOrig)];
    }
    for (PNEArcView* arc in arcs) {
        [arc drawArc];
    }}

}

@end
