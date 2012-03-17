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

- (id) init {
    if (self = [super init]) { 
        tokens = [[NSMutableArray alloc] init];
        dimensions = PLACE_DIMENSION;}
    return self;
}

- (id) initWithView:(PNEView*) view {
    if (self = [super initWithView:view]) {
        dimensions = PLACE_DIMENSION;
        tokens = [[NSMutableArray alloc] init];}
    return self;
}

- (id) initWithValues: (PNPlace*) pnElement superView: (PNEView*) view {
    if (self = [super initWithValues: pnElement superView: view]) {
        tokens = [[NSMutableArray alloc] init];
        [superView.places addObject:self];
        pnElement.view = self;
        
        //Add all the tokens
        for (PNToken *token in pnElement.tokens) {
            PNETokenView *tokenView = [[PNETokenView alloc] initWithValues:token superView:superView];
            [self addToken:tokenView];}
        
        dimensions = PLACE_DIMENSION;} 
    return self;
}

- (void) dealloc {
    [tokens dealloc];
    [superView.places removeObject:self];
    [super dealloc];
}

- (void) updateMidPoint {
    midPointX = xOrig + dimensions / 2;
    midPointY = yOrig + dimensions / 2;
    distanceFromMidPoint = (dimensions/2) / sqrt(2);
}

- (void) multiplyDimension: (CGFloat) multiplier {
    [super multiplyDimension:multiplier];
    [self updateMidPoint];
}


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

- (void) addToken:(PNETokenView *)token {
    [tokens addObject:token];
}

- (void) drawSingleToken {
    PNETokenView *theToken = [tokens objectAtIndex:0];
    [theToken drawToken:CGPointMake(midPointX - TOKEN_DIMENSION / 2, midPointY - TOKEN_DIMENSION / 2)];
}

- (void) drawTwoTokens {
    PNETokenView *token1 = [tokens objectAtIndex:0];
    PNETokenView *token2 = [tokens objectAtIndex:1];
    
    [token1 drawToken:CGPointMake(midPointX - TOKEN_DIMENSION - TOKEN_DISTANCE, midPointY - TOKEN_DIMENSION / 2)];
    [token2 drawToken:CGPointMake(midPointX + TOKEN_DISTANCE, midPointY - TOKEN_DIMENSION / 2)];
}

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

- (void) highlightNode {
    [super highlightNode];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_WIDTH / 2, yOrig - HL_WIDTH / 2, dimensions + HL_WIDTH, dimensions + HL_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, HL_WIDTH / 2);
    CGContextStrokePath(context);
}

//Needs a relook, quickly made before demo
- (void) dimNode {
    [super dimNode];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig - HL_WIDTH / 2, yOrig - HL_WIDTH / 2, dimensions + HL_WIDTH, dimensions + HL_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, HL_WIDTH + 1);
    CGContextStrokePath(context);
    
    [self drawNode:CGPointMake(xOrig, yOrig)];
}

- (void) drawNode:(CGPoint) origin {
    [super drawNode:origin];
    [self updateMidPoint];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(xOrig, yOrig, dimensions, dimensions);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGContextStrokePath(context);

    [self drawTokens];
}

@end