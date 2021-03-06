//
//  PNEViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 8/11/11.
//  Copyright (c) 2011 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEPadViewController.h"

@implementation PNEPadViewController

@synthesize infoView, contextInformation;
@synthesize labelVisibility;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    petriNetView.contextInformation = contextInformation;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark View rotating behaviour

/**
 Hides the infoview (log and context info) when the iPad
 changes to landscape mode.
 */
-(void)rotatePad:(UIInterfaceOrientation)nextOrientation
{
    if(UIDeviceOrientationIsPortrait(nextOrientation))
        infoView.hidden = NO;
    else infoView.hidden = YES;
    [petriNetView checkPositions];
}

/**
 This is called by the system when the iPad is about to be rotated.
 It calls the rotatePad: function which handles the hidding or displaying
 of some elements depending on the orientation.
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self rotatePad:toInterfaceOrientation];
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

/**
 This method is called by the system to see if the 
 application should respond to a rotation of the device.
 @param interfaceOrientation
    The orientation that might be supported
 @return 
    true if the viewcontroller supports the interfaceorientation
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Action responders

/**
 Called by the system when the add button is pressed
 */
- (IBAction)addButtonPress:(id)sender {
    [addOptionsSheet showFromBarButtonItem:addButton animated:YES];
}

/**
 This updates the visibility of the labels
 if the user changed the segmented control
 */
- (IBAction)labelVisibilityChanged:(id)sender {
    if (labelVisibility.selectedSegmentIndex == 0)
        petriNetView.showLabels = true;
    else petriNetView.showLabels = false;
    [petriNetView setNeedsDisplay];
}

@end
