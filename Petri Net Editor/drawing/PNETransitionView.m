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

#pragma mark - Lifecycle

/**
 Instantiates the transition based on the original PNTransition.
 a PNEArcView is created for every PNTransition#inputs or
 PNTransition#outputs part of the original PNTransition.

 */
- (id) initWithElement: (PNTransition*) pnElement andSuperView: (PNEView*) view {
    if (self = [super initWithElement:pnElement andSuperView:view]) {
        
        //Only add the option to fire a transition if it's external
        if (pnElement.priority == EXTERNAL)
            [nodeOptions addButtonWithTitle:@"Fire Transition"];
        nodeOptions.cancelButtonIndex = [nodeOptions addButtonWithTitle:CANCEL_BUTTON_NAME];
        
        [superView.transitions addObject:self];
        type = pnElement.priority;
        
        if (!hasLocation) dimensions = TRANSITION_DIMENSION;
    
        //Create and convert all the input arcs
        [pnElement.inputs retain];
        for (PNPlace* fromPlace in [pnElement.inputs allKeys]) {
            PNEArcView *arcView = [[PNEArcView alloc] initWithElement:[pnElement.inputs objectForKey:fromPlace] andSuperView:superView]; 
            [arcView setFromNode:fromPlace.view andToNode:self];
        }
            
        //Do the same for the output arcs
        [pnElement.outputs retain];
        for (PNPlace* toPlace in [pnElement.outputs allKeys]) {
            PNEArcView *arcView = [[PNEArcView alloc] initWithElement:[pnElement.outputs objectForKey:toPlace] andSuperView:superView]; 
            [arcView setFromNode:self andToNode:toPlace.view];
        }
    }
    return self;
}

- (void) dealloc {
    [superView.transitions removeObject:self];
    [super dealloc];
}

/**
 Removes the transition from the superview
 */
- (void) removeElement {
    [superView.manager removeTransition:element];
    
    //Remove the transition from all the neighbours
    // If the transition is not a neighbour of a certain
    // place nothing happens
    for (PNEPlaceView* place in superView.places) {
        [place removeNeighbour:self];
    }
    
    [super removeElement];
}

/**
 Allows us to copy the transition to add it to a 
 NSMutableDictionary.
 We return a self pointer instead of an actual copy.
 */
- (id) copyWithZone:(NSZone *)zone {
    return [self retain];
}

#pragma mark - Touch logic

/**
 Handles a a tap (short touch) event.
 @see PNEView#transitionTapped:
 */
- (void) handleTapGesture: (UITapGestureRecognizer *) gesture {
    [superView transitionTapped:self];
}

#pragma mark Options sheet methods

/**
 This is called by the system when the actionsheet receives touch input
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    
    if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"Fire Transition") {
        [self fireTransition];
    }
}

/**
 Fires the PNTransition and updates the PNEView
 */
- (void) fireTransition {
    @try {
        [superView.manager fireTransition:element];
        [superView.log addText:[NSString stringWithFormat:@"%@ \n \t %@",FIRE_TRANSITION_PREFIX, label]];
        [superView updatePlaces];
    }
    @catch (NSException *exception) {
        NSString *title = [NSString stringWithFormat:@"Error firing transition %@", label];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:[exception reason]
                                      delegate: self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

#pragma mark - Highlight implementation

/**
 Draws the higlight "aura".
 */
- (void) drawHighlight {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_LINE_WIDTH / 2, yOrig - HL_LINE_WIDTH / 2, dimensions + HL_LINE_WIDTH, dimensions + HL_LINE_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, HL_LINE_WIDTH);
    CGContextStrokeRect(context, rect);
}

#pragma mark - Drawing code

/**
 Draws the transition.
 */
- (void) drawNode {  
    [super drawNode];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);

    if (type == EXTERNAL) CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    if (type == INTERNAL) CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    if (type == CLEANING) CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);

    CGContextFillRect(context, rect);
    
    //Restore the fill color
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokeRect(context, rect);
}

@end
