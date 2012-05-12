//
//  PNEFileViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 12/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../data/PNEFileManager.h"

@interface PNEFileViewController : UIViewController {
    UIView *superView;
        
    UINavigationBar *bar;
    UIBarButtonItem *doneButton;
    
    UITextView *fileView;
    UITableView *folderView;
    
    PNEFileManager *fileManager;
}

@property (nonatomic, retain) IBOutlet UIView *superView;

@property (nonatomic, retain) IBOutlet UINavigationBar *bar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, retain) IBOutlet UITextView *fileView;
@property (nonatomic, retain) IBOutlet UITableView *folderView;


- (IBAction)doneButtonPressed:(id)sender;

//- (IBAction)didPan:(id)sender;


@end
