//
//  PNEPlaceView.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEPlaceView.h"
#import "PNEView.h"

@implementation PNEPlaceView

#pragma mark - Lifecycle

/**
 Initialised the PNEPlaceView from a given Place. It also initialised a PNETokenView
 for each PNToken that PNPlace contains.
 */
- (id) initWithValues: (PNPlace*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues: pnElement superView: view]) {
        [nodeOptions addButtonWithTitle:@"Show reachable contexts"];
        [nodeOptions addButtonWithTitle:@"Add token"];
        nodeOptions.cancelButtonIndex = [nodeOptions addButtonWithTitle:@"Cancel"];
        tokens = [[NSMutableArray alloc] init];
        neighbours = [[NSMutableDictionary alloc] init];
        [superView.places addObject:self];
        
        if (!hasLocation) dimensions = PLACE_DIMENSION;
        
        //Add all the tokens
        for (PNToken *token in pnElement.tokens) {
            PNETokenView *tokenView = [[PNETokenView alloc] initWithValues:token superView:superView];
            [self addToken:tokenView];}
        } 
    return self;
}

- (void) dealloc {
    [tokens release];
    [superView.places removeObject:self];
    [super dealloc];
}

/**
 Removes the place after ensuring
 every PNArcInscription connected to the
 matching PNPlace is removed.
 */
- (void) removeNode {
    [superView.manager removePlace:element];
    
    for (PNETransitionView *trans in neighbours) {
        if ([[neighbours objectForKey:trans] boolValue]) 
            [trans.element removeInput:self.element];
        else [trans.element removeOutput:self.element];
    }
    
    [super removeNode];
}

#pragma mark - Neighbours

/**
 Adds a reference to a transition connected to this place
 */
- (void) addNeighbour: (PNETransitionView*) trans isInput: (BOOL) isInput {
    [neighbours setObject:[NSNumber numberWithBool:isInput] forKey:trans];
}

/**
 Removes a neighbour of this place
 */
- (void) removeNeighbour: (PNETransitionView*) trans {
    [neighbours removeObjectForKey:trans];
}

#pragma mark - Touch logic

/**
 Handles a tap (short press) gesture.
 */
- (void) handleTapGesture: (UITapGestureRecognizer *) gesture {
    [superView placeTapped:self];
}

/**
 Handles a long press gesture.
 */
- (void) handleLongGesture: (UILongPressGestureRecognizer *) gesture {
    [nodeOptions showFromRect:touchView.bounds inView:touchView animated:true];
}

#pragma mark - Highlight protocol implementation

/**
 Draws the highlight "aura" of the place.
 */
- (void) drawHighlight {
    [superView.contextInformation updateText:[NSString localizedStringWithFormat:@"Selected context: %@ \n \t tokens: %d", label, [tokens count]]];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_LINE_WIDTH / 2, yOrig - HL_LINE_WIDTH / 2, dimensions + HL_LINE_WIDTH, dimensions + HL_LINE_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, HL_LINE_WIDTH / 2);
    CGContextStrokePath(context);
}

#pragma mark - Options sheet methods

/**
 The system calls this when an option of the actionsheet is selected.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
}

#pragma mark - Arc attachement point functions

- (CGPoint) getLeftTopPoint {
   return CGPointMake(midPointX - distanceFromMidPoint, midPointY - distanceFromMidPoint);
}

- (CGPoint) getRightTopPoint {
    return CGPointMake(midPointX + distanceFromMidPoint, midPointY - distanceFromMidPoint);
}

- (CGPoint) getLeftBottomPoint {
    return CGPointMake(midPointX - distanceFromMidPoint, midPointY + distanceFromMidPoint);
}
- (CGPoint) getRightBottomPoint; {
    return CGPointMake(midPointX + distanceFromMidPoint, midPointY + distanceFromMidPoint);
}

#pragma mark - Help functions

/**
 Updates the location of the midpoint of the
 circle after moving the node.
 */
- (void) updateMidPoint {
    midPointX = xOrig + dimensions / 2;
    midPointY = yOrig + dimensions / 2;
    distanceFromMidPoint = (dimensions / 2) / sqrt(2);
}

/**
 Changes the dimension of the place
 @see PNENodeView#multiplyDimension:
 */
- (void) multiplyDimension: (CGFloat) multiplier {
    [super multiplyDimension:multiplier];
    [self updateMidPoint];
}

/**
 Adds a PNETokenView to the token array
 */

- (void) addToken:(PNETokenView *)token {
    [tokens addObject:token];
}

/**
 Updates the token array depending on the amount of token the matching PNPlace contains
 */
- (void) updatePlace {
    [tokens removeAllObjects];
    
    for (PNToken *token in [element tokens]) {
        PNETokenView *tokenView = [[PNETokenView alloc] initWithValues:token superView:superView];
        [self addToken:tokenView];}
    
}

#pragma mark - Drawing code

/**
 Draws a single PNETokenView in the centre of the circle.
 */
- (void) drawSingleToken {
    PNETokenView *theToken = [tokens objectAtIndex:0];
    [theToken drawToken:CGPointMake(midPointX - TOKEN_DIMENSION / 2, midPointY - TOKEN_DIMENSION / 2)];
}

/**
 Draws 2 tokens side by side in the centre of the circle.
 */
- (void) drawTwoTokens {
    PNETokenView *token1 = [tokens objectAtIndex:0];
    PNETokenView *token2 = [tokens objectAtIndex:1];
    
    [token1 drawToken:CGPointMake(midPointX - TOKEN_DIMENSION - TOKEN_DISTANCE, midPointY - TOKEN_DIMENSION / 2)];
    [token2 drawToken:CGPointMake(midPointX + TOKEN_DISTANCE, midPointY - TOKEN_DIMENSION / 2)];
}

/**
 Draws 3 tokens in a cirlce inside the place.
 */
- (void) drawThreeTokens {
    PNETokenView *token1 = [tokens objectAtIndex:0];
    PNETokenView *token2 = [tokens objectAtIndex:1];
    PNETokenView *token3 = [tokens objectAtIndex:2];

    CGPoint leftTop = [self getLeftTopPoint];
    CGPoint rightTop = [self getRightTopPoint];
    CGPoint bottom = [self getBottomEdge];
    
    [token1 drawToken:CGPointMake(leftTop.x , leftTop.y)];
    [token2 drawToken:CGPointMake(rightTop.x - TOKEN_DIMENSION, rightTop.y)];    
    [token3 drawToken:CGPointMake(bottom.x - TOKEN_DIMENSION / 2, bottom.y - TOKEN_DIMENSION - TOKEN_DISTANCE)];
}

/**
 Draws 4 tokens, once in each corner.
 */
- (void) drawFourTokens {
    PNETokenView *token1 = [tokens objectAtIndex:0];
    PNETokenView *token2 = [tokens objectAtIndex:1];
    PNETokenView *token3 = [tokens objectAtIndex:2];
    PNETokenView *token4 = [tokens objectAtIndex:3];
    
    CGPoint leftTop = [self getLeftTopPoint];
    CGPoint rightTop = [self getRightTopPoint];
    CGPoint leftBottom = [self getLeftBottomPoint];
    CGPoint rightBottom = [self getRightBottomPoint];
    
    [token1 drawToken:CGPointMake(leftTop.x , leftTop.y)];
    [token2 drawToken:CGPointMake(rightTop.x - TOKEN_DIMENSION, rightTop.y)];    
    [token3 drawToken:CGPointMake(leftBottom.x, leftBottom.y - TOKEN_DIMENSION)];
    [token4 drawToken:CGPointMake(rightBottom.x - TOKEN_DIMENSION, rightBottom.y - TOKEN_DIMENSION)];
}

/**
 Draws the number of tokens in the centre of the circle.
 */
- (void) drawMultipleTokens {
    //Prepare the text
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSelectFont(context, MAIN_FONT_NAME, MAIN_FONT_SIZE, kCGEncodingMacRoman);
    
    //Calculate the amount of tokens, convert it into a C string and calculate the string length
    NSUInteger tokenAmount = [tokens count];
    NSString *tempText = [NSString stringWithFormat:@"%d", tokenAmount];
    NSUInteger textLength = [tempText length];
    const char *tokenText = [tempText cStringUsingEncoding: [NSString defaultCStringEncoding]];
    
    //Calculate text width
    CGPoint startPoint = CGContextGetTextPosition(context);
    CGContextSetTextDrawingMode(context, kCGTextInvisible);
    CGContextShowText(context, tokenText, textLength);
    CGPoint endPoint = CGContextGetTextPosition(context);
    CGFloat textWidth = endPoint.x - startPoint.x;
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    
    //Inverse the text to makeup for the difference between the uikit and core graphics coordinate systems
    CGAffineTransform flip = CGAffineTransformMakeScale(1, -1);
    CGContextSetTextMatrix(context, flip);
    
    CGContextShowTextAtPoint(context, midPointX - textWidth / 2, midPointY + MAIN_FONT_SIZE / 2 , tokenText, textLength);
    
}

/**
 Decides how many tokens should be drawn.
 */
- (void) drawTokens {
    switch ([tokens count]) {
        case 0:
            break;
        case 1:
            [self drawSingleToken];
            break;
        case 2:
            [self drawTwoTokens];
            break;
        case 3:
            [self drawThreeTokens];
            break;
        case 4:
            [self drawFourTokens];
            break;
        default:
            [self drawMultipleTokens];
            break;
    }
}

/**
 Moves the place to a new location.
 @see PNENodeView#moveNode:
 */
- (void) moveNode:(CGPoint)origin {
    [super moveNode:origin];
    [self updateMidPoint];
}

/**
 Draws the place and every PNETokenView part of the tokens array.
 */
- (void) drawNode {
    [super drawNode];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);

    [self drawTokens];
}

@end