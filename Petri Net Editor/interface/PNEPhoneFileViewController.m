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
 This method opens a context declaration with a name.
 We hide the folder view and open up the file in the 
 now visibile file view.
 @see PNEFileViewController::openContextDeclaration:
 */
- (void) openContextDeclaration: (NSString*) name {
    [super openContextDeclaration:name];

    UINavigationItem *file = [[UINavigationItem alloc] initWithTitle:name];
    file.rightBarButtonItem = doneButton;
    [navBar pushNavigationItem:file animated:true];

    folderView.hidden = YES;
    fileView.hidden = NO;
}

/**
 Changes the folder (this is done in PNEFileViewController::changeFolder:)
 Aftewards it changes the navigationbar.
 @see PNEFileViewController::changeFolder:
 */
- (void) changeFolder: (NSString*) name {
    [super changeFolder:name];
    
    UINavigationItem *folder = [[UINavigationItem alloc] initWithTitle:name];
    folder.rightBarButtonItem = doneButton;
    [navBar pushNavigationItem:folder animated:true];
    [folder release];
}

/**
 This method is called by the system
 when the done button is pressed.
 This can do two things. If we are currently
 editing a file it will hide the keyboard.
 Otherwise it hides the fileviewcontroller.
 @see PNEFileViewController::doneButtonPressed:
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
 are in the fileview.
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
