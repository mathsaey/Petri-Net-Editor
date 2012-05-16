//
//  PNEPhoneFileViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 16/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEPhoneFileViewController.h"

@implementation PNEPhoneFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    fileView.hidden = YES;
}

/**
 This method opens a context declaration with a name
 We hide the folder view and open up the file in the 
 now visibile file view.
 */
- (void) openContextDeclaration: (NSString*) name {
    UINavigationItem *file = [[UINavigationItem alloc] initWithTitle:name];
    file.rightBarButtonItem = doneButton;
    [navBar pushNavigationItem:file animated:true];

    [super openContextDeclaration:name];
    folderView.hidden = YES;
    fileView.hidden = NO;
}

/**
 This method is called by the system
 when the done button is pressed.
 To allow the user to use the toolbar 
 after typing in the fileView the done button
 hides the keyboard when we are watching the file view.
 */
- (void) doneButtonPressed:(id)sender {
    if (!fileView.hidden) {
        [fileView endEditing:YES];
    }
    else [super doneButtonPressed:sender];
}

/**
 This method is called by the system when the navigation
 bar pops an item (generally when the back button is pressed).
 We use it to return to the previous folder.
 This method takes us back to the folderview if we
 are in the fileview
 */
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    if (fileView.hidden) {
        [fileManager returnToFolder];
        [self reloadData];
    }
    else {
        folderView.hidden = NO;
        fileView.hidden = YES;
        [fileView endEditing:YES];
    }
}      

@end
