//
//  PNEView.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 14/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

//This class represents the view where the Petri Net is drawn


#import <UIKit/UIKit.h>
#import "PNEPlaceView.h"
#import "PNEViewElement.h"
#import "PNETransitionView.h"

@interface PNEView : UIView

@end


/*
Beginnen met alle plaatsen te zoeken en in array te plaatsen
 Alle transitions beginnen tekenen, elke arc die we tegenkomen tekenen
 
 

*/