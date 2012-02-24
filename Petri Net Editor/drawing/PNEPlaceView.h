//
//  PNEPlaceView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "../kernel/PNPlace.h"
#import "PNETokenView.h"
#import "PNENodeView.h"

@interface PNEPlaceView : PNENodeView {
    NSMutableArray *tokens;
    CGFloat distanceFromMidPoint;
    CGFloat midPointX;
    CGFloat midPointY;
}


@end
