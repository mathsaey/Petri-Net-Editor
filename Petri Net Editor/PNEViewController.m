//
//  PNEViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 21/03/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEViewController.h"

@implementation PNEViewController

@synthesize log, petriNetView;

#pragma mark - Initialisers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    addOptionsSheet = [[UIActionSheet alloc] initWithTitle:@"Add:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Place", @"Transition", @"Arc" , nil];}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [petriNetView release];
    [log release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"Abstract version of shouldAutorotateToInterfaceOrientation (PNEViewController) called!");
    return false;
}

#pragma mark - Action responders

- (IBAction)addButtonPress:(id)sender {
    NSLog(@"Abstract version of addButtonPress (PNEViewController) called!");
}

//Action sheet delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [petriNetView addPlace];
            break;
        case 1:
            [petriNetView addTransition];
            break;
        case 2: 
            [petriNetView addArc];
            break;
    };
}

@end
