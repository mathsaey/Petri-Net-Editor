//
//  PNInternalTransition.h
//  context
//
//  Created by NicolasCardozo on 18/03/12.
//  Copyright 2012 Université catolique de Louvain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNTransition.h"

@class SCContextManager;

/*
 Internal transitions which fire with a must fire semantics
*/ 
@interface PNInternalTransition : PNTransition {

    
}

- (id) initWithName:(NSString *) newName;

/** Internal transitions that are enabled are added into a priority list to fire automatically
 @see PNTransition
 */ 
-(BOOL) checkEnabledWithColor:(NSNumber *)color;

@end
