//
//  PNExternalTransition.h
//  context
//
//  Created by NicolasCardozo on 18/03/12.
//  Copyright 2012 Université catolique de Louvain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNTransition.h"

@interface PNExternalTransition : PNTransition {

    
}

- (id) initWithName:(NSString *) newName;

/** External transitions are always marked
 @see PNTransition
 */
-(BOOL) checkEnabledWithColor:(NSNumber *)color;

@end
