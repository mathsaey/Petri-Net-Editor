//
//  PNEPlaceView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNENodeView.h"
#import "PNPlace.h"

@interface PNEPlaceView : PNENodeView {
    CGFloat distanceFromMidPoint;
    CGFloat midPointX;
    CGFloat midPointY;
}

- (id) initWithElement:(PNPlace *)pnElement;
- (void) drawNode:(CGFloat)x yVal:(CGFloat)y;

- (CGPoint) getLeftTopPoint;
- (CGPoint) getRightTopPoint;
- (CGPoint) getLeftBottomPoint;
- (CGPoint) getRightBottomPoint;

- (void) multiplyDimension: (CGFloat) multiplier;


@end
