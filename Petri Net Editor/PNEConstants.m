//
//  PNEConstants.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

// This file contains the constants used throughout the code

const CGFloat MAIN_FONT_SIZE = 20;
const char *MAIN_FONT_NAME = "Helvetica Neue";

const int HORIZONTAL_NODES = 4;
const int VERTICAL_NODES = 4;
const CGFloat START_OFFSET_X = 30;
const CGFloat START_OFFSET_Y = 30;

const int MAX_TOKENS = 3;
const CGFloat LINE_WIDTH = 2;
const CGFloat ARC_END_SIZE = 10;
const CGFloat HL_LINE_WIDTH = 5;

const CGFloat PLACE_DIMENSION = 45;
const CGFloat TRANSITION_DIMENSION = 25;
const CGFloat LABEL_DISTANCE = 5;

const CGFloat TOKEN_DISTANCE = 2;
const CGFloat TOKEN_DIMENSION = 15; //Should be around place_dimension/3

const CGFloat ARC_TOUCH_MIN = 20;
//Minimum dimensions of the arc touch rect
const CGFloat ARC_TOUCH_BASE = 30; 
//A lower value indicates more touch rectangles for arcs
//Setting this value too low can cause slowdowns when moving nodes
