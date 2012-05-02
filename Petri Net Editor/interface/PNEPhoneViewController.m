//
//  PNEPhoneViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEPhoneViewController.h"

@implementation PNEPhoneViewController

@synthesize logButton;
@synthesize viewContainer;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    petriNetView.showLabels = false; //Labels are disabled on the iphone version
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark View rotating behaviour

//Petri net enkel weergeven in horizontale modus? Log in verticale modus 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Action responders

/**
 Called by the system when the add button gets pressed.
 */
- (IBAction)addButtonPress:(id)sender {
    [addOptionsSheet showInView:petriNetView];
}

/**
 Hides or shows the log and expands the PNEView accordingly
 */
- (IBAction)toggleLog:(id)sender {
    log.hidden = !log.hidden;
    
    if (log.hidden) {
        [petriNetView setFrame:viewContainer.bounds];
    }
    else [petriNetView setFrame:
          CGRectMake(viewContainer.bounds.origin.x, viewContainer.bounds.origin.y, viewContainer.bounds.size.width, 
                     viewContainer.bounds.size.height - log.bounds.size.height)];
    
    [petriNetView checkPositions];
}

@end
