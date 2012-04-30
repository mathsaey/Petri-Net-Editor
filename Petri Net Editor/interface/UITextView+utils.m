//
//  UITextView+utils.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 26/04/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "UITextView+utils.h"

@implementation UITextView (ContextUtils)

/**
 Erases all the text in the view
 */
- (void) clearText {
    self.text = @"";
}

/**
 Appends text to the end of the view
 @param string
    The string to append.
 */
- (void) addText: (NSString*) string {
    self.text = [NSString stringWithFormat:@"%@ %@ \n", self.text, string];
    [self scrollRangeToVisible:NSMakeRange([self.text length], 0)];
}

@end
