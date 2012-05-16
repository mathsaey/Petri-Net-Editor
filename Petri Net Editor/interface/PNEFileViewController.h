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

/**
 @author Mathijs Saey
 This class is responsible for the file browser.
 The actual file handling is done by the PNEFileManager,
 this class provides the interface.
 */
@interface PNEFileViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate> {
    NSString *currentFileName; /**< Name of the currently opened file */
    
    UINavigationBar *navBar; /**< Navigation bar to browse the directory tree */
    UIBarButtonItem *addFolderButton; /**< Button that allows the user to add a folder */
    
    UIBarButtonItem *doneButton; /**< Button that allows the user to return to the PNEViewController */
    UIBarButtonItem *saveButton; /**< Button that allows the user to save the current file */
    UIBarButtonItem *mailButton; /**< Button that allows the user to mail the current file */
    UIBarButtonItem *parseButton; /**< Button that parses the current file and returns to the PNEViewController */
    UIBarButtonItem *addFileButton; /**< Button that allows the user to add a new file */
    
    UITextView *fileView; /**< View that displays the current file */
    UITableView *folderView; /**< View that shows the directory tree */
    
    PNEFileManager *fileManager; /**< File manager that handles the files */
    NSArray *folders; /**< Array containing all directories in the current directory */
    NSArray *files; /**< Array that contains all the files in the current direcoty */
}

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


@interface PNEFileViewController (protected)

- (void) reloadData;
- (void) openContextDeclaration: (NSString*) name;

@end
