//
//  PNEViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 21/03/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../drawing/PNEView.h"

/**
 @author Mathijs
 
 This class contains all methods and members that both the iPad and the iPhone viewcontrollers use
 */
@interface PNEViewController : UIViewController <UIActionSheetDelegate> {
    UITextView *log;
    PNEView *petriNetView;
    UIActionSheet *addOptionsSheet;
    
    UIBarButtonItem *addButton;
    UIBarButtonItem *reloadButton;
    UIBarButtonItem *organiseButton;
    UIBarButtonItem *screenshotButton;
    
    //Debug
    UIBarButtonItem *testButton;
}

@property (nonatomic, readonly) IBOutlet UITextView *log;
@property (nonatomic, readonly) IBOutlet PNEView *petriNetView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *organiseButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *reloadButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *screenshotButton;

- (IBAction)addButtonPress:(id)sender;
- (IBAction)organiseButtonPressed:(id)sender;
- (IBAction)reloadButtonPressed:(id)sender;
- (IBAction)screenshotButtonPressed:(id)sender;

//Debug
@property (nonatomic, retain) IBOutlet UIBarButtonItem *testButton;
- (IBAction)testButtonFire:(id)sender;

@end
