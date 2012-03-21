//
//  PNEView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 14/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PNEView.h"

#import "PNEArcView.h"
#import "PNEPlaceView.h"
#import "PNEViewElement.h"
#import "PNETransitionView.h"

#import "../kernel/PNManager.h"


@interface PNEView : UIView {
    NSMutableArray *arcs;
    NSMutableArray *places;
    NSMutableArray *transitions;
        
    PNManager *manager;
    
    BOOL showLabels;
}

@property (atomic, readwrite) BOOL showLabels;
@property (nonatomic, readonly) PNManager *manager;
@property (nonatomic, readonly) NSMutableArray *arcs, *places, *transitions;

@end
