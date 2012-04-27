//
//  PNETransitionView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNENodeView.h"
#import "../UITextView+utils.h"
#import "../kernel/PNTransition.h"


/**
 @author Mathijs Saey

 This class is the visual representation of a PNTransition.
 a PNTransition is represented by a full square.
 */
@interface PNETransitionView : PNENodeView <NSCopying>

@end
