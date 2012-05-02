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
 @author Mathijs Saey

 This class is the visual representation of a PNToken.
 A token is a filled circle and is placed inside a PNEPlaceView.
 */
@interface PNETokenView : PNEViewElement {
    NSNumber *tokenColor;
}

- (void) drawToken: (CGPoint) origin;

@end
