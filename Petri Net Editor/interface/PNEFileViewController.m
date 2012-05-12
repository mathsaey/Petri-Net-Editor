//
//  PNEFileViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 12/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEFileViewController.h"

@implementation PNEFileViewController

@synthesize doneButton, bar, fileView, folderView;
@synthesize superView;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        fileManager = [[PNEFileManager alloc] init];
    }
    return self;
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


- (void) openContextDeclaration: (NSString*) name {
    fileView.text = [fileManager getContextDeclaration:name];
}

- (void) populate: (NSString*) path {
    
    NSArray *fileList = [fileManager getFolderContent];
    for (NSString* tmp in fileList) {
        NSLog(tmp);
    }
        
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
        interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	return YES;
    else return YES;
}

- (IBAction)doneButtonPressed:(id)sender {
    [self populate:@"/"];
    
    //[self returnToMainViewController];
}

- (void) returnToMainViewController {
    [self dismissModalViewControllerAnimated:true];
}


@end
