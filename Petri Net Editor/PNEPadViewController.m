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
@synthesize mainToolbar, addButton, labelVisibility;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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

-(void)rotatePad:(UIInterfaceOrientation)nextOrientation
{
    if(UIDeviceOrientationIsPortrait(nextOrientation))
        infoView.hidden = NO;
    else infoView.hidden = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self rotatePad:toInterfaceOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Action responders


- (IBAction)addButtonPress:(id)sender {
    [addOptionsSheet showFromBarButtonItem:addButton animated:YES];
}

- (IBAction)labelVisibilityChanged:(id)sender {
    if (labelVisibility.selectedSegmentIndex == 0)
        petriNetView.showLabels = true;
    else petriNetView.showLabels = false;
    [petriNetView setNeedsDisplay];
}

@end
