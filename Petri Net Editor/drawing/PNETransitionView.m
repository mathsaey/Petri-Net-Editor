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

- (id) initWithValues: (PNTransition*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues:pnElement superView:view]) {
        [nodeOptions addButtonWithTitle:@"Fire Transition"];
        nodeOptions.cancelButtonIndex = [nodeOptions addButtonWithTitle:@"Cancel"];
        [superView.transitions addObject:self];
        dimensions = TRANSITION_DIMENSION;
    
        //Create and convert all the input arcs
        [pnElement.inputs retain];
        for (PNPlace* fromPlace in [pnElement.inputs allKeys]) {
            PNEArcView *arcView = [[PNEArcView alloc] initWithValues:[pnElement.inputs objectForKey:fromPlace] superView:superView]; 
            [arcView setNodes:fromPlace.view toNode:self];
        }
            
        //Do the same for the output arcs
        [pnElement.outputs retain];
        for (PNPlace* toPlace in [pnElement.outputs allKeys]) {
            PNEArcView *arcView = [[PNEArcView alloc] initWithValues:[pnElement.outputs objectForKey:toPlace] superView:superView]; 
            [arcView setNodes:self toNode:toPlace.view];
        }
    }
    return self;
}

- (void) dealloc {
    [superView.transitions removeObject:self];
    [super dealloc];
}

#pragma mark - Touch logic

- (void) handleTapGesture: (UITapGestureRecognizer *) gesture {
    [superView transitionTapped:self];
}

#pragma mark Options sheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    
    if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        [superView.manager removeTransition:element];
        [superView.transitions removeObject:self];
        [superView setNeedsDisplay];
    }
    
    else if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"Fire Transition") {
        [superView.manager fireTransition:self.element];
        [superView updatePlaces];
    }
}

#pragma mark - Highlight protocol implementation

- (void) drawHighlight {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_LINE_WIDTH / 2, yOrig - HL_LINE_WIDTH / 2, dimensions + HL_LINE_WIDTH, dimensions + HL_LINE_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, HL_LINE_WIDTH);
    CGContextStrokeRect(context, rect);
}

#pragma mark - Drawing code

- (void) drawNode {  
    [super drawNode];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);

    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rect);
}

@end
