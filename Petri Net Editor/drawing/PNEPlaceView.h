//
//  PNEPlaceView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "../kernel/PNPlace.h"
#import "PNENodeView.h"
@class PNETokenView;

@interface PNEPlaceView : PNENodeView { 
    NSMutableArray *tokens;
    CGFloat distanceFromMidPoint;
    CGFloat midPointX;
    CGFloat midPointY;
}

- (void) addToken: (PNETokenView*) token;

@end
