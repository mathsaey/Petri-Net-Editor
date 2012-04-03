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

- (IBAction)addArcButtonPres:(id)sender {
    printf("Placeholder! \n");
}

- (IBAction)addPlaceButtonPres:(id)sender {
    printf("Placeholder! \n");
}

- (IBAction)addTransitionButtonPres:(id)sender {
    printf("Placeholder! \n");
}


//Action sheet delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            printf("Add place placeholder \n"); //place
            break;
        case 1:
            printf("Add Transition placeholder \n"); //Transition
            break;
        case 2: 
            printf("Add Arc placeholder \n"); //Arc
            break;
        default:
            printf("no idx");
            break;
    };
}

@end
