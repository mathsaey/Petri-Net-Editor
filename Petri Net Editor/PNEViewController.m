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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    addOptionsSheet = [[UIActionSheet alloc] initWithTitle:@"Add:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Place", @"Transition", @"Arc" , nil];}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addButtonPress:(id)sender {
    NSLog(@"Abstract version of addButtonPress (PNEViewController) called!");
}

//Action sheet delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            printf("Add place placeholder \n");
            PNPlace *newPlace = [[PNPlace alloc] initWithName:@"New Place"];
            [petriNetView.manager addPlace:newPlace];
            break;
        case 1:
            printf("Add Transition placeholder, initialiser makes the next addition crash \n");
            PNTransition *newTrans = [[PNTransition alloc] initWithName:@"New Transition"];
            [petriNetView.manager addTransition:newTrans];
            break;
        case 2: 
            printf("Add Arc placeholder \n"); //Arc
            break;
    };
    
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        [petriNetView loadKernel];
    }
}

@end
