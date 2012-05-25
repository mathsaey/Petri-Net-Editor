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
#import "PNEView.h"

/**
 @author Mathijs Saey
 
 This class contains a collection of all
 places and transitions part of a context
 This makes it easier to group elements of a certain context.
 
 Due to the nature of a context this class is 
 very hardcoded and very dependant on the kernel.
 */
@interface PNEContextCollection : NSObject {
    NSMutableArray *collection;
    
    PNEPlaceView *contextPlace;
    
    PNEPlaceView *prPlace;
    PNEPlaceView *prnPlace;
    PNEPlaceView *negPlace;
    
    PNETransitionView *clTrans;
    
    PNETransitionView *reqTrans;
    PNETransitionView *reqnTrans;
    
    PNETransitionView *actTrans;
    PNETransitionView *deacTrans;
}

@property (readonly) PNEPlaceView* contextPlace;

- (id) initWithContextPlace: (PNEPlaceView*) cPlace andView: (PNEView*) view;
- (void) removeElement: (PNENodeView*) node;
- (void) placeContext: (CGPoint) orig;
- (CGFloat) getHeight;

@end

