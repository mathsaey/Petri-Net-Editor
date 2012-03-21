//
//  PNEViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 8/11/11.
//  Copyright (c) 2011 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawing/PNEView.h"
#import "PNEViewController.h"

@interface PNEPadViewController : PNEViewController {
   
    UIView *infoView;
    UITextView *contextInformation;    
    
    UIToolbar *mainToolbar;
    UIBarButtonItem *addButton;
    UISegmentedControl *labelVisibility;
    
    //Toolbar add buttons
    UIToolbar *addToolbar;
    UIBarButtonItem *backButton;
    UIBarButtonItem *addArcButton;
    UIBarButtonItem *addPlaceButton;
    UIBarButtonItem *addTransitionButton;

}

@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UITextView *contextInformation;

@property (nonatomic, retain) IBOutlet UIToolbar *mainToolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl *labelVisibility;

@property (nonatomic, retain) IBOutlet UIToolbar *addToolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addArcButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addPlaceButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addTransitionButton;

- (IBAction)backButtonPress:(id)sender;
- (IBAction)labelVisibilityChanged:(id)sender;

@end
