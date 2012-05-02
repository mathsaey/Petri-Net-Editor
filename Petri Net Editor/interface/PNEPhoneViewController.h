//
//  PNEPhoneViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNEViewController.h"
#import "../drawing/PNEView.h"


@interface PNEPhoneViewController : PNEViewController {
    UIBarButtonItem *logButton;
    UIView *viewContainer;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *logButton;
@property (nonatomic, retain) IBOutlet UIView *viewContainer;


- (IBAction)toggleLog:(id)sender;

@end
