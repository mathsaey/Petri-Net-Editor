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
        
        collection = [[NSArray alloc] initWithObjects:cPlace, prPlace, prnPlace, negPlace, clTrans, reqTrans, reqnTrans, actTrans, deacTrans, nil];
        
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

- (void) addTouchresponders {
    for (PNENodeView* node in collection) {
        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoublePanGesture:)];
        tap.minimumNumberOfTouches = 2;
        [node addTouchResponder:tap];
        [tap release];
    }
}

- (void) handleDoublePanGesture: (UIPanGestureRecognizer *) gesture {
    CGPoint translation = [gesture translationInView:contextPlace.superView];
    [gesture setTranslation:CGPointMake(0, 0) inView:contextPlace.superView];
    
    for (PNENodeView* node in collection) {
        [node moveNode:CGPointMake(node.xOrig + translation.x, node.yOrig + translation.y)];
    }
    
    [contextPlace.superView setNeedsDisplay];
}
- (CGPoint) getRightPointFrom: (PNENodeView*) fromNode To: (PNENodeView*) toNode WithVerticalDistance: (CGFloat) distance shouldFlip: (BOOL) flip {
    int multiplier = flip ? 1 : -1;
    CGFloat y = fromNode.yOrig + (((fromNode.dimensions - toNode.dimensions) / 2) + multiplier * distance);
    return CGPointMake(fromNode.xOrig + fromNode.dimensions + X_CONTEXT_DISTANCE, y);
}

/**
 This method places the context elements depending on the position of the contextPlace
 */
- (void) placeContext {
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


@end
