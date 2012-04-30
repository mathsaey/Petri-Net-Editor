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

@interface PNEPadViewController : PNEViewController {
   
    UIView *infoView;
    UITableView *contextInformation;    
    
    UISegmentedControl *labelVisibility;
}

@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UITableView *contextInformation;
@property (nonatomic, retain) IBOutlet UISegmentedControl *labelVisibility;

- (IBAction)labelVisibilityChanged:(id)sender;


@end