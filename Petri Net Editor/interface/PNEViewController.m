//
//  PNEViewController.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 21/03/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEViewController.h"

#import "../data/PNParser.h"

@implementation PNEViewController

@synthesize log, petriNetView;
@synthesize addButton, reloadButton, organiseButton, screenshotButton, trashButton;

#pragma mark - Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [super viewDidLoad];
        petriNetView.log = log;
        addOptionsSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"ADD_TITLE", nil) delegate:self 
                                             cancelButtonTitle:NSLocalizedString(@"CANCEL_BUTTON", nil) destructiveButtonTitle:nil
                                             otherButtonTitles:NSLocalizedString(@"CONTEXT_TITLE", nil), 
                           NSLocalizedString(@"TRANS_TITLE", nil),
                           NSLocalizedString(@"ARC_TITLE", nil) , nil];
    }
    return self;
}

- (void) dealloc {
    [petriNetView release];
    [log release];
    [super dealloc];
}

#pragma mark - View lifecycle

/**
 [abstract] This method is called by the system to ask if the device
 can rotate.
 @param interfaceOrientation
    The orientation that might be supported
 @return 
    true if the viewcontroller supports the interfaceorientation
 @see PNEPadViewController::shouldAutorotateToInterfaceOrientation:
 @see PNEPhoneViewController::shouldAutorotateToInterfaceOrientation:
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"Abstract version of shouldAutorotateToInterfaceOrientation (PNEViewController) called!");
    return false;
}

/**
 This method is called by the system when the device will
 be rotated
 @param interfaceOrientation
 The orientation that will be assumed.
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [petriNetView setNeedsDisplay];
}

#pragma mark - Action responders
/**
 [abstract] This method is called after the add Button has been pressed
 */
- (IBAction)addButtonPress:(id)sender {
    NSLog(@"abstract version of addButtonPress (PNEViewController) called!");
}

/**
 This method is called when the reload button is pressed.
 */
- (IBAction)reloadButtonPressed:(id)sender {
    [petriNetView resetPositions];
}

/**
 This method is called when the screenshot button is pressed.
 It asks the PNEView a UIImage version of itself, after wich it exports
 the UIImage to the photo album of the device.
 */
- (IBAction)screenshotButtonPressed:(id)sender {
    UIImage *pnImage = [petriNetView getPetriNetImage];
    UIImageWriteToSavedPhotosAlbum(pnImage, NULL, NULL, NULL);
}

/**
 This method empties the kernel.
 */
- (IBAction)trashButtonPressed:(id)sender {
    [PNManager trashManager];
    [petriNetView loadKernel];
}

/**
 Triggers a pop up dialog prompting the user
 to select the name of the new context/transition
 */
- (void) askLabel: (NSString*) title {
    UIAlertView *popup = [[UIAlertView alloc] 
                          initWithTitle:title message:nil 
                          delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL_BUTTON", nil) 
                          otherButtonTitles:NSLocalizedString(@"OK_BUTTON", nil), nil];
    popup.alertViewStyle = UIAlertViewStylePlainTextInput;
    [popup show];
    [popup release];
}

/**
 Simply calls the corresponding PNEView method
 */
- (void) addContext: (NSString*) label {
    [petriNetView addContext:label];
}

/**
 Simply calls the corresponding PNEView method
 */
- (void) addTransition: (NSString*) label {
    [petriNetView addTransition:label];
}

/**
 This method is called by the system when the user selects
 an item on a UIActionSheet. In this case it's used after
 the user selects which item to add.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self askLabel:NSLocalizedString(@"ADD_CONTEXT_TITLE", nil)];
            break;
        case 1:
            [self askLabel:NSLocalizedString(@"ADD_TRANS_TITLE", nil)];
            break;
        case 2: 
            [petriNetView addArc];
            break;
    };
}

/**
 This method is called by the system when the user has entered the new
 context/transition name. The title of the UIAlertView determines the
 method that gets called.
 */
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        [name retain];
        
        if (alertView.title == NSLocalizedString(@"ADD_CONTEXT_TITLE", nil))
            [self addContext:name];
        else [self addTransition:name];
        [name release];
    }
}

@end
