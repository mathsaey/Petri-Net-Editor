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


@interface PNETokenView : PNEViewElement {
    UIColor *tokenColor;
}

- (void) drawToken: (CGPoint) origin;

@end
