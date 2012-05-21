//
//  PNEContextCollection.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 16/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PNETransitionView.h"
#import "PNEPlaceView.h"

/**
 @author Mathijs Saey
 This class contains a collection of all
 places and transitions part of a context
 This makes it easier to group elements of a certain context.
 
 Due to the nature of a context this class is 
 very hardcoded and very dependant on the kernel.
 */
@interface PNEContextCollection : NSObject {
    NSArray *collection;
    
    PNEPlaceView *contextPlace;
    
    PNEPlaceView *prPlace;
    PNEPlaceView *pnrPlace;
    PNEPlaceView *negPlace;
    
    PNETransitionView *reqTrans;
    PNETransitionView *reqnTrans;
    
    PNETransitionView *actTrans;
    PNETransitionView *deacTrans;
}

//- (void) placeCollection: (CGPoint*) position;

@end


///@todo Add touchresponders to nodes. Ensure it needs 2 fingers.
///@todo Add Context wise displaying
