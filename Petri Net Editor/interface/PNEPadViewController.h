//
//  PNEViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 8/11/11.
//  Copyright (c) 2011 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNEViewController.h"
#import "../drawing/PNEView.h"

/**
 This class extends the PNEViewController
 with iPad functionality.
 */
@interface PNEPadViewController : PNEViewController {
    UIView *infoView; /**< This view contains the contextinformation and the log */
    UITextView *contextInformation; /** This text view displays the information of the selected contexts */
    UISegmentedControl *labelVisibility; /** This segmented control is used to select if the labels are visible or not */
}

@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UITextView *contextInformation;
@property (nonatomic, retain) IBOutlet UISegmentedControl *labelVisibility;

- (IBAction)labelVisibilityChanged:(id)sender;


@end
