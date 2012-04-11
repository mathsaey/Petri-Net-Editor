//
//  PNEViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 8/11/11.
//  Copyright (c) 2011 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNEViewController.h"
#import "drawing/PNEView+PNEGraphDrawingCategory.h"

@interface PNEPadViewController : PNEViewController {
   
    UIView *infoView;
    UITextView *contextInformation;    
    
    UIToolbar *mainToolbar;
    UIBarButtonItem *addButton;
    UISegmentedControl *labelVisibility;
    
    //Debug
    UIBarButtonItem *testButton;
}

@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UITextView *contextInformation;

@property (nonatomic, retain) IBOutlet UIToolbar *mainToolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl *labelVisibility;

//Debug
@property (nonatomic, retain) IBOutlet UIBarButtonItem *testButton;
- (IBAction)testButtonFire:(id)sender;

- (IBAction)labelVisibilityChanged:(id)sender;

@end
