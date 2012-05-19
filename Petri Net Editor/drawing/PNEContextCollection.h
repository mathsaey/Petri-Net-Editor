//
//  PNEContextCollection.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 16/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PNETemporaryPlaceView.h"
#import "PNEContextPlaceView.h"
#import "PNETransitionView.h"

@interface PNEContextCollection : NSObject {
    PNEContextPlaceView *contextPlace;
}

@end
