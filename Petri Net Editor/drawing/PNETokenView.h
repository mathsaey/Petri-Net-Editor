//
//  PNETokenView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEViewElement.h"
#import "../PNEConstants.h"
#import "../kernel/PNToken.h"

/**
 This class is the visual representation of a PNToken.
 */
@interface PNETokenView : PNEViewElement {
    UIColor *tokenColor;
}

/**
 Draws a token on a certain location
 @param origin
    The location where the upper left point of the token should be
 */
- (void) drawToken: (CGPoint) origin;

@end
