//
//  PNEFileViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 12/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEFileViewController.h"

@implementation PNEFileViewController

@synthesize doneButton, saveButton, mailButton, parseButton, addFileButton; 
@synthesize fileView, folderView, navBar, addFolderButton;
@synthesize superView;

#pragma mark - View lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        fileManager = [[PNEFileManager alloc] init];
        files = [fileManager getFilesInFolder];
        folders = [fileManager getFoldersInFolder];
    }
    return self;
}

- (void) dealloc {
    [fileManager release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Help functions

- (void) reloadData {
    files = [fileManager getFilesInFolder];
    folders = [fileManager getFoldersInFolder];
    [folderView reloadData];
}

- (void) printError: (NSString*) errorMessage {
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error:" message:errorMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [error show];
}

- (void) printAskNameField: (NSString*) title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark - File handling

- (void) openContextDeclaration: (NSString*) name {
    currentFileName = name;
    fileView.text = [fileManager getContextDeclaration:name];
}

- (void) saveContextDeclaration {
    if (currentFileName != nil)
        [fileManager putContextDeclaration:currentFileName withContents:fileView.text];
}

- (void) parseContextDeclaration {
    if (currentFileName != nil && [fileManager parseFile:currentFileName]) {
        [self returnToMainViewController];
    }
}

#pragma mark UITableView delegate methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellLabel = [folderView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    if (indexPath.row < [folders count]) {
        [fileManager changeFolder:cellLabel];
        
        UINavigationItem *folder = [[UINavigationItem alloc] initWithTitle:cellLabel];
        folder.rightBarButtonItem = addFolderButton;
        
        [navBar pushNavigationItem:folder animated:true];
        [self reloadData];
    }
    //Files
    else [self openContextDeclaration:cellLabel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *newCell = [[UITableViewCell alloc] init];
    
    //Folders
    if (indexPath.row < [folders count]) {
        newCell.textLabel.text = [folders objectAtIndex:indexPath.row];
        newCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //Files
    else {
        newCell.textLabel.text = [files objectAtIndex:indexPath.row - [folders count]];
    }
    
    return newCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [files count] + [folders count];
}
 

#pragma mark - Action responders

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    [fileManager returnToFolder];
    [self reloadData];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSString* name = [alertView textFieldAtIndex:0].text;  
        
        if ([alertView.title isEqualToString:@"File name:"]) {
            [fileManager putContextDeclaration:name withContents:@""];
            [self openContextDeclaration:name];
        }
        
        else if ([alertView.title isEqualToString:@"Folder name:"]) {
            [fileManager addFolder:name];
        }
        
        [self reloadData];
    }
}

- (IBAction)addFolderButtonPressed:(id)sender {
    [self printAskNameField:@"Folder name:"];
}

- (IBAction)addFileButtonPressed:(id)sender {
    [self printAskNameField:@"File name:"];
}

- (IBAction)doneButtonPressed:(id)sender {
   [self returnToMainViewController];
}

- (IBAction)saveButtonPressed:(id)sender {
    if (currentFileName != nil)
        [self saveContextDeclaration];
    else [self printError:@"There is no open file!"];
}

- (IBAction)mailButtonPressed:(id)sender {
    if (currentFileName != nil && [MFMailComposeViewController canSendMail]) {
        //Store the data and load it into a buffer
        [self saveContextDeclaration];
        NSData *buffer = [fileManager getContextDeclarationBuffer:currentFileName];
        
        //Open a mailcomposer and add the file as an attachement
        MFMailComposeViewController *mailComposer  = [[MFMailComposeViewController alloc] init];
        [mailComposer addAttachmentData:buffer mimeType:nil fileName:currentFileName];
        
        //Set some options and show the mail window
        mailComposer.mailComposeDelegate = self;
        [mailComposer setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentModalViewController:mailComposer animated:YES];
        [mailComposer release];
    }
    
    else if (currentFileName == nil) [self printError:@"There is no open file!"];
    else [self printError:@"It's not possible to send emails on this device"];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error { 
    [controller dismissModalViewControllerAnimated:true];
}

- (IBAction)parseButtonPressed:(id)sender {
    if (currentFileName != nil) {
        [self saveContextDeclaration];
        [self parseContextDeclaration];
    }
    else [self printError:@"There is no open file!"];
}

- (void) returnToMainViewController {
    [self dismissModalViewControllerAnimated:true];
}

@end
