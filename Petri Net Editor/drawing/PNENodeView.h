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


/**
 This class is the visual representation of a PNNode.
 */
@interface PNENodeView : PNEViewElement <UIActionSheetDelegate, UIAlertViewDelegate> {
    BOOL hasLocation; /** Boolean that keeps track if the node already has a position in the PNEView */
    BOOL isMarked; /** Boolean that keeps track of the highlight status */
        
    CGFloat xOrig; /** X value of the top-left corner of the square that contains the node */
    CGFloat yOrig; /** Y value of the top-left corner of the square that contains the node */
    CGFloat dimensions; /** Dimensions of the square that contains the node */
    
    NSString *label; /** Reference to the label of the PNNode */

    UIView *touchView; /** View that contains the touch responders of the node */
    UIActionSheet *nodeOptions; /** Action sheet that presents the user with options */
}

@property (readonly) BOOL hasLocation;
@property (readonly) BOOL isMarked;
@property (readonly) CGFloat xOrig;
@property (readonly) CGFloat yOrig;
@property (readonly) CGFloat dimensions;
@property (readonly) NSMutableArray* neighbours;

/**
 Removes the PNNode counterpart from the kernel
 */
- (void) removeNode;

//============
//Drawing Code
//============
/**
 @name Drawing Code
 @{
 */

/**
 Draws the node
 */
- (void) drawNode;

/**
 Moves the node to a new position.
 @param origin
    the position to move the node to.
 */
- (void) moveNode: (CGPoint) origin;

///@}

//============
//Highlighting
//============
/**
 @name Highlighting
 These functions implement the highlight logic
 @{
 */

/**
 Draws the highlight "aura"
 */
- (void) drawHighlight;

/**
 Switches the highlightstatus to off if it was on and vice versa 
 */
- (void) toggleHighlightStatus;

/**
 Turns on the highlight
 */
- (void) highlight;

/**
 Turns off the highlight
 */
- (void) dim;

///@}

//================
//Touch responders
//================
/**
 @name Touch responders
 These functions get called after certain user actions
 @{
 */

- (void) handleLongGesture: (UILongPressGestureRecognizer *) gesture;
- (void) handleTapGesture: (UITapGestureRecognizer *) gesture;
- (void)handlePanGesture:(UIPanGestureRecognizer *) gesture;

///@}

//==================
//Position functions
//==================
/**
 @name Position Functions
 These functions get a certain point on the node
 @{
 */

- (CGPoint) getTopEdge;
- (CGPoint) getLeftEdge;
- (CGPoint) getRightEdge;
- (CGPoint) getBottomEdge;
- (CGPoint) getLeftTopPoint;
- (CGPoint) getRightTopPoint;
- (CGPoint) getLeftBottomPoint;
- (CGPoint) getRightBottomPoint;

///@}


//===============
//Position checks
//===============
/**
 @name Position checks
 These functions check how 2 node are positioned in relation to each other.
 @{
 */

- (BOOL) isLower: (PNENodeView*) node;
- (BOOL) isHigher: (PNENodeView*) node;
- (BOOL) isLeft: (PNENodeView*) node;
- (BOOL) isRight: (PNENodeView*) node;
- (BOOL) isLeftAndLower: (PNENodeView*) node;
- (BOOL) isRightAndLower: (PNENodeView*) node;
- (BOOL) isLeftAndHigher: (PNENodeView*) node;
- (BOOL) isRightAndHigher: (PNENodeView*) node;

/**
 Checks if 2 nodes overlap
 @param node
    The node to compare to the self node
 */
- (BOOL) doesOverlap: (PNENodeView*) node;

///@}

/**
 Changes the dimension of the node
 @param multiplier
    A multiplier that decides how the node scales
 */
- (void) multiplyDimension: (CGFloat) multiplier;

@end
