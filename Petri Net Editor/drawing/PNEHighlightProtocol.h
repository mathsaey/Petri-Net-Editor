//
//  PNEHighlightProtocol.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 21/03/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

// This protocol ensures that a certain element can be highlighted

#import <Foundation/Foundation.h>

@protocol PNEHighlightProtocol <NSObject> 

@required
- (void) highlight;
- (void) toggleHighlightStatus;

@end
