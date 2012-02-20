//
//  PNEViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 8/11/11.
//  Copyright (c) 2011 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawing/PNEView.h"

@interface PNEPadViewController : UIViewController{
   
    UITextView *log;
    UIView *infoView;
    PNEView *petriNetView;
    UITextView *contextInformation;

}

@property (nonatomic, retain) IBOutlet UITextView *log;
@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet PNEView *petriNetView;
@property (nonatomic, retain) IBOutlet UITextView *contextInformation;


@end
