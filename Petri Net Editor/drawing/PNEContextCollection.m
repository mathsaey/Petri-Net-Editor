//
//  PNEContextCollection.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 16/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEContextCollection.h"

//Some extra private properties
@interface PNEContextCollection()
@property (readwrite, weak) PNEPlaceView *contextPlace;
@property (readwrite, weak) PNEPlaceView *prPlace;
@property (readwrite, weak) PNEPlaceView *prnPlace;
@property (readwrite, weak) PNEPlaceView *negPlace;
@property (readwrite, weak) PNETransitionView *reqTrans;
@property (readwrite, weak) PNETransitionView *reqnTrans;
@property (readwrite, weak) PNETransitionView *clTrans;
@property (readwrite, weak) PNETransitionView *actTrans;
@property (readwrite, weak) PNETransitionView *deacTrans;
@end


@implementation PNEContextCollection

@synthesize contextPlace, prPlace, prnPlace, negPlace, clTrans, reqTrans, reqnTrans, actTrans, deacTrans;

- (id) initWithContextPlace: (PNEPlaceView*) cPlace andView: (PNEView*) view {
    if (self = [super init]) {
        self.contextPlace = cPlace;
        
        //Find which places belong to the context
        for (PNEPlaceView* place in view.places) {
            if ([place.label isEqualToString:[@"PR." stringByAppendingString:cPlace.label]])
                self.prPlace = place;
            else if ([place.label isEqualToString:[@"PRN." stringByAppendingString:cPlace.label]])
                self.prnPlace = place;
            else if ([place.label isEqualToString:[@"NEG." stringByAppendingString:cPlace.label]])
                self.negPlace = place;
        }
        
        //Find the transitions that belong to the context
        for (PNETransitionView* trans in view.transitions) {
            if ([trans.label isEqualToString:[@"req." stringByAppendingString:cPlace.label]])
                self.reqTrans = trans;
            else if ([trans.label isEqualToString:[@"reqn." stringByAppendingString:cPlace.label]])
                self.reqnTrans = trans;
            else if ([trans.label isEqualToString:[@"cl." stringByAppendingString:cPlace.label]])
                self.clTrans = trans;
            else if ([trans.label isEqualToString:[@"act." stringByAppendingString:cPlace.label]])
                self.actTrans = trans;
            else if ([trans.label isEqualToString:[@"deac." stringByAppendingString:cPlace.label]])
                self.deacTrans = trans;
        }
        
        collection = [[NSMutableArray alloc] initWithObjects:
                      cPlace, prPlace, prnPlace, negPlace, 
                      clTrans, reqTrans, reqnTrans, 
                      actTrans, deacTrans, nil];
        
        for (PNENodeView *node in collection) {
            node.collection = self;
        }
        
        [self addTouchresponders];
        [view.collections addObject:self];
    }
    return self;
}

- (void) dealloc {
    [super dealloc];
    [collection release];
    
    //We let the properties take care of the
    //reference counting.
    self.contextPlace = nil;
    self.prPlace = nil;
    self.prnPlace = nil;
    self.negPlace = nil;
    self.clTrans = nil;
    self.reqTrans = nil;
    self.reqnTrans = nil;
    self.actTrans = nil;
    self.deacTrans = nil;
}

/**
 This method adds the context 
 touch responders to all the context elements
 */
- (void) addTouchresponders {
    for (PNENodeView* node in collection) {
        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoublePanGesture:)];
        tap.minimumNumberOfTouches = 2;
        [node addTouchResponder:tap];
        [tap release];
    }
}

/**
 This method is called by the system
 when a node receives a pan (dragging)
 gesture with at least 2 fingers
 */
- (void) handleDoublePanGesture: (UIPanGestureRecognizer *) gesture {
    CGPoint velocity = [gesture translationInView:contextPlace.superView];
    [gesture setTranslation:CGPointMake(0, 0) inView:contextPlace.superView];

    for (PNENodeView* node in collection) {
        [node moveNode:CGPointMake(node.xOrig + velocity.x, node.yOrig + velocity.y)];
    }
    [contextPlace.superView setNeedsDisplay];
}

/**
 This method calculates where to draw a node
 in relation to another node.
 @param fromNode
    The node that will be left of the new node
 @param toNode
    The node that will be positioned
 @param distance
    The height difference between both nodes
 @param shouldFlip
    This determines if the toNode needs to be placed
    above or below the fromNode
 
 @return
    The point where the toNode should be placed
 */
- (CGPoint) getRightPointFrom: (PNENodeView*) fromNode To: (PNENodeView*) toNode WithVerticalDistance: (CGFloat) distance shouldFlip: (BOOL) flip {
    //Ensure we always have a reference point
    if (fromNode == nil) fromNode = contextPlace;
        
    int multiplier = flip ? 1 : -1;
    CGFloat y = fromNode.yOrig + (((fromNode.dimensions - toNode.dimensions) / 2) + multiplier * distance);
    return CGPointMake(fromNode.xOrig + fromNode.dimensions + X_CONTEXT_DISTANCE, y);
}

/**
 This method places the context elements depending on the position of the contextPlace.
 */
- (void) placeContext: (CGPoint) orig {    
    [contextPlace moveNode:CGPointMake(orig.x, orig.y + ([self getHeight] / 2) - contextPlace.dimensions / 2)];
    
    [actTrans moveNode:[self getRightPointFrom:contextPlace To:actTrans WithVerticalDistance:Y_CONTEXT_DISTANCE shouldFlip:false]];
    [deacTrans moveNode:[self getRightPointFrom:contextPlace To:deacTrans WithVerticalDistance:Y_CONTEXT_DISTANCE shouldFlip:true]];
    
    //The 3 temporary places are linked to the internal transitions
    [prPlace moveNode:[self getRightPointFrom:actTrans To:prPlace WithVerticalDistance:0 shouldFlip:false]];
    [prnPlace moveNode:[self getRightPointFrom:deacTrans To:prnPlace WithVerticalDistance:Y_CONTEXT_DISTANCE / 2 shouldFlip:false]];
    [negPlace moveNode:[self getRightPointFrom:deacTrans To:negPlace WithVerticalDistance:Y_CONTEXT_DISTANCE / 2 shouldFlip:true]];
    
    //The 3 transitions are positioned on the same level as the places they attach to.
    [reqTrans moveNode:[self getRightPointFrom:prPlace To:reqTrans WithVerticalDistance:0 shouldFlip:false]];
    [reqnTrans moveNode:[self getRightPointFrom:prnPlace To:reqnTrans WithVerticalDistance:0 shouldFlip:false]];
    [clTrans moveNode:[self getRightPointFrom:negPlace To:clTrans WithVerticalDistance:0 shouldFlip:false]];
}

/**
 This method calculates the height
 difference between the top and 
 bottom node.
 @return 
    The height difference
 */
- (CGFloat) getHeight {
    //Return the number based on the way
    //placeContext places the nodes.
    //This needs to be hardcoded since we
    //cannot calculate the height before 
    //positioning otherwise
    return 2.5 * Y_CONTEXT_DISTANCE;
}

/**
 Removed an element from the collection
 This is used when a single node from the collection
 is deleted.
 
 This method is there to keep the collection array
 up to data so we don't worry about updating the
 other ivars.
 
 @param node
    The node to remove
 */
- (void) removeElement: (PNENodeView*) node {
    [collection removeObject:node];
}

@end
