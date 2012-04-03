//
//  PNETransitionView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNETransitionView.h"
#import "PNEView.h"

@implementation PNETransitionView

- (id) init {
    if (self = [super init]) {
        dimensions = TRANSITION_DIMENSION;        
    }
    return self;
}

- (id) initWithView:(PNEView*) view {
    if (self = [super initWithView:view]) 
        dimensions = TRANSITION_DIMENSION;
    return self;
}

//TODO: add more abstractions
- (id) initWithValues: (PNTransition*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view]) {
        [superView.transitions addObject:self];
        dimensions = TRANSITION_DIMENSION;
    
        //Get all the input arcs
        for (PNPlace* fromPlace in pnElement.inputs) {
            PNEArcView *arcView = [[PNEArcView alloc] initWithValues:[pnElement.inputs objectForKey:fromPlace] superView:superView]; 
            [superView.arcs addObject:arcView];
            arcView.toNode = self;
            
            for (PNEPlaceView* placeView in superView.places) {
                if (placeView.element.code == fromPlace.code)
                    arcView.fromNode = placeView;
            }
        }
        
        //Do the same for the output arcs
        for (PNPlace* toPlace in pnElement.outputs) {
            PNEArcView *arcView = [[PNEArcView alloc] initWithValues:[pnElement.outputs objectForKey:toPlace] superView:superView]; 
            [superView.arcs addObject:arcView];
            arcView.fromNode = self;
            
            for (PNEPlaceView* placeView in superView.places) {
                if (placeView.element.code == toPlace.code)
                    arcView.toNode = placeView;
            }
        }
    }
    return self;
}

- (PNEPlaceView*) findPlace: (PNPlace*) place {
    for (PNEPlaceView* placeView in superView.places) {
        if (placeView.element.code == place.code)
            return placeView;
    }
    return NULL;
}

/*
 - (void) createArc: (PNPlace*) placeKey trans: (PNTransition*) trans dictionary: (NSMutableDictionary*) dict isInput: (BOOL) isInput {
 PNEArcView *arcView = [[PNEArcView alloc] initWithValues:[dict objectForKey:placeKey] superView:superView];
 [superView.arcs addObject:arcView];
 if (isInput) {
 arcView.toNode = trans.view;
 arcView.fromNode = placeKey.view;}
 else {
 arcView.fromNode = trans.view;
 arcView.toNode = placeKey.view;
 }
 }
 */

- (void) dealloc {
    [superView.transitions removeObject:self];
    [super dealloc];
}

- (void) highlight {
    [super highlight];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_WIDTH / 2, yOrig - HL_WIDTH / 2, dimensions + HL_WIDTH, dimensions + HL_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, HL_WIDTH);
    CGContextStrokeRect(context, rect);
}

//Needs a relook, quickly made before demo
- (void) dim {
    [super dim];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_WIDTH / 2, yOrig - HL_WIDTH / 2, dimensions + HL_WIDTH, dimensions + HL_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, HL_WIDTH);
    CGContextStrokeRect(context, rect);
}

- (void) drawNode: (CGPoint) origin {
    [super drawNode:origin];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);

    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rect);
}

@end
