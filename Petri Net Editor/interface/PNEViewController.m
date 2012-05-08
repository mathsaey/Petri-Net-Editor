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
@synthesize addButton, reloadButton, organiseButton, screenshotButton;

//debug code
@synthesize testButton;

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
    petriNetView.log = log;
    addOptionsSheet = [[UIActionSheet alloc] initWithTitle:@"Add:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Context", @"Transition", @"Arc" , nil];
}

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
 [placeholder code] This method is called when the organise button has been pressed
 */
- (IBAction)organiseButtonPressed:(id)sender {
    NSLog(@"Placeholder!");
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

- (IBAction)trashButtonPressed:(id)sender {
    [[[PNManager sharedManager] places] removeAllObjects];
    [[[PNManager sharedManager] temporaryPlaces] removeAllObjects];
    [[[PNManager sharedManager] transitions] removeAllObjects];
    [petriNetView loadKernel];
}

/**
 Triggers a pop up dialog prompting the user
 to select the name of the new context/transition
 */
- (void) askLabel: (NSString*) title {
    UIAlertView *popup = [[UIAlertView alloc] 
                          initWithTitle:title message:nil 
                          delegate:self cancelButtonTitle:@"Cancel" 
                          otherButtonTitles:@"Confirm", nil];
    popup.alertViewStyle = UIAlertViewStylePlainTextInput;
    [popup show];
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
            [self askLabel:ADD_CONTEXT_ALERTVIEW_TITLE];
            break;
        case 1:
            [self askLabel:ADD_TRANSITION_ALERTVIEW_TITLE];
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
        
        if (alertView.title == ADD_CONTEXT_ALERTVIEW_TITLE)
            [self addContext:name];
        else [self addTransition:name];
    }
}

#pragma mark - Test code

- (IBAction)testButtonFire:(id)sender {
    [petriNetView insertData];
}

@end
