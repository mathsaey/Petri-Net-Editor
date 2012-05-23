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

/**
 @author Mathijs Saey
 This class extents the PNEViewController for the
 iPhone version.
*/
@interface PNEPhoneViewController : PNEViewController {
    UIBarButtonItem *logButton; /**< This button controls the visibility of the log */
    UIView *viewContainer; /**< This view contains the PNEView and the log */
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *logButton;
@property (nonatomic, retain) IBOutlet UIView *viewContainer;


- (IBAction)toggleLog:(id)sender;

@end
