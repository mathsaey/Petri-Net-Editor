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

@interface PNEFileViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate> {
    NSString *currentFileName;
    UIView *superView;
        
    UINavigationBar *navBar;
    UIBarButtonItem *addFolderButton;
    
    UIBarButtonItem *doneButton;
    UIBarButtonItem *saveButton;
    UIBarButtonItem *mailButton;
    UIBarButtonItem *parseButton; 
    UIBarButtonItem *addFileButton;

    UITextView *fileView;
    UITableView *folderView;
    
    PNEFileManager *fileManager;
}

@property (nonatomic, retain) IBOutlet UIView *superView;

@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addFolderButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *mailButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *parseButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addFileButton;


@property (nonatomic, retain) IBOutlet UITextView *fileView;
@property (nonatomic, retain) IBOutlet UITableView *folderView;

- (IBAction)addFolderButtonPressed:(id)sender;
- (IBAction)addFileButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)mailButtonPressed:(id)sender;
- (IBAction)parseButtonPressed:(id)sender;


@end
