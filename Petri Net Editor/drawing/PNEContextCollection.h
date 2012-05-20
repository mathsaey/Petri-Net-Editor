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


/**
 @author Mathijs Saey
 This class contains a collection of all
 places and transitions part of a context
 This makes it easier to group elements of a certain context.
 
 Due to the nature of a context this class is 
 very hardcoded and very dependant on the kernel.
 */
@interface PNEContextCollection : NSObject {
    PNEContextPlaceView *contextPlace;
    
    PNETemporaryPlaceView *prPlace;
    PNETemporaryPlaceView *pnrPlace;
    PNETemporaryPlaceView *negPlace;
    
    PNETransitionView *reqTrans;
    PNETransitionView *reqnTrans;
    
    PNETransitionView *actTrans;
    PNETransitionView *deacTrans;
}

//- (void) placeCollection: (CGPoint*) position;

@end