//
//  PNEPadFileViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 23/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEPadFileViewController.h"

@implementation PNEPadFileViewController

#pragma mark - View lifecycle

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

/**
 
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

/**
 Opens a folder and adjusts
 the navigation bar
 */
- (void) changeFolder: (NSString*) name {
    [super changeFolder:name];
    
    UINavigationItem *folder = [[UINavigationItem alloc] initWithTitle:name];
    folder.rightBarButtonItem = addFolderButton;
    [navBar pushNavigationItem:folder animated:true];
    [folder release];
}

@end
