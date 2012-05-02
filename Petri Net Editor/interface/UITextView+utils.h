//
//  UITextView+utils.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 26/04/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEConstants.h"

/**
 @author Mathijs Saey

 This category expands the UITextView with some 
 functionality to make it easier to update the
 log and context information
 */
@interface UITextView (utils)


- (void) clearText;
- (void) addText: (NSString*) string;

@end

