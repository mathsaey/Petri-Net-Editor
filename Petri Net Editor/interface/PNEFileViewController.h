//
//  PNEFileViewController.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 12/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../data/PNEFileManager.h"

#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PNEFileViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    NSString *currentFileName;
    UIView *superView;
        
    UINavigationBar *bar;
    UIBarButtonItem *doneButton;
    UIBarButtonItem *saveButton;
    UIBarButtonItem *mailButton;
    UIBarButtonItem *parseButton;
    
    
    UITextView *fileView;
    UITableView *folderView;
    
    PNEFileManager *fileManager;
}

@property (nonatomic, retain) IBOutlet UIView *superView;

@property (nonatomic, retain) IBOutlet UINavigationBar *bar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *mailButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *parseButton;

@property (nonatomic, retain) IBOutlet UITextView *fileView;
@property (nonatomic, retain) IBOutlet UITableView *folderView;


- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)mailButtonPressed:(id)sender;
- (IBAction)parseButtonPressed:(id)sender;


@end
