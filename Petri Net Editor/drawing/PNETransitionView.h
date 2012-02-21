//
//  PNETransitionView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNENodeView.h"
#import "PNTransition.h"

@interface PNETransitionView : PNENodeView

- (id) initWithElement:(PNTransition *)pnElement;
- (void) drawNode: (CGFloat) x yVal: (CGFloat) y;


@end
