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
@interface PNEViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate> {
    UITextView *log; /**< Link to the log */
    PNEView *petriNetView; /**< Link to the view that contains the Petri Net */
    UIActionSheet *addOptionsSheet; /** The option sheet that presents the user with the options to add elements to the Petri Net */
    
    UIBarButtonItem *addButton; /** Link to the button that shows the addOptionsSheet */
    UIBarButtonItem *trashButton; /** Button that empties the kernel */
    UIBarButtonItem *reloadButton; /** Button that resets the positions of all the nodes */
    UIBarButtonItem *organiseButton; /** Button that should lead to the saving and loading options */
    UIBarButtonItem *screenshotButton; /** Button that makes a picture of the petri net */
    
    //Debug
    UIBarButtonItem *testButton;
}

@property (nonatomic, readonly) IBOutlet UITextView *log;
@property (nonatomic, readonly) IBOutlet PNEView *petriNetView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *trashButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *organiseButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *reloadButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *screenshotButton;

- (IBAction)addButtonPress:(id)sender;
- (IBAction)organiseButtonPressed:(id)sender;
- (IBAction)reloadButtonPressed:(id)sender;
- (IBAction)screenshotButtonPressed:(id)sender;
- (IBAction)trashButtonPressed:(id)sender;

//Debug
@property (nonatomic, retain) IBOutlet UIBarButtonItem *testButton;
- (IBAction)testButtonFire:(id)sender;

@end
