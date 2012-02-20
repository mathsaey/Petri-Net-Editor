//
//  PNEPhoneViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawing/PNEView.h"

@interface PNEPhoneViewController : UIViewController{
    
    UITextView *log;   
    PNEView *petriNetView;
}

@property (nonatomic, retain) IBOutlet UITextView *log;
@property (nonatomic, retain) IBOutlet PNEView *petriNetView;



@end
