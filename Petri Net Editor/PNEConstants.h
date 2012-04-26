//
//  PNEConstants.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

// This file contains the constants used throughout the code

/**
 @defgroup PNEConstants
 This group contains all the constants used throughout the code.
 Edit these constants to fine tune the behaviour of the Petri Net Editor.
 @{
 */

//Font constants
//==============

extern CGFloat MAIN_FONT_SIZE; /**< Size of the main font */
extern char *MAIN_FONT_NAME; /**< Name of the main font */

//Full Petri Net drawing constants
//================================
extern CGFloat START_OFFSET_X; /**< X position of the first node */
extern CGFloat START_OFFSET_Y; /**< Y position of the first node */

//Element Drawing constants
//=========================

//general
extern int MAX_TOKENS; /**< Maximum tokens of a place before we just draw the number of tokens */
extern CGFloat LINE_WIDTH; /**< Width of a drawn line */
extern CGFloat ARC_END_SIZE; /**< Size of the arrow / circle at the end of the arc */
extern CGFloat HL_LINE_WIDTH; /**< Width of the highlight line */

//Node constants
extern CGFloat PLACE_DIMENSION; /**< Size of a place */
extern CGFloat TRANSITION_DIMENSION; /**< Size of a transition */
extern CGFloat LABEL_DISTANCE; /**< Distance between a node and it's label */

//Token drawing constants
extern CGFloat TOKEN_DISTANCE; /**< Distance between tokens */
extern CGFloat TOKEN_DIMENSION; /**< Size of a token, this value should be around a third of the PLACE_DIMENSION */

//Arc touch constants
/**
 The minimum dimensions of a touchview on an arc.
 A higher value means it's easier to touch an arc, 
 but it also increases the chance of a toucharea overriding
 another touch zone.*/
extern CGFloat ARC_TOUCH_MIN;

/**
 The amount of touch rectangles drawn on an arc depending on the x-distance
 between the start and end.
 
 A lower value will result in more touch rectangles for an arc.
 This makes it easier for the user to touch the arc.
 The lower this number the higher the memory consumption will be.
 */
extern CGFloat ARC_TOUCH_BASE; 

///@}