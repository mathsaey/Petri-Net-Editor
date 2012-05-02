//
//  PNTemporaryPlace.h
//  context
//
//  Created by NicolasCardozo on 20/03/12.
//  Copyright 2012 Université catolique de Louvain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPlace.h"

/**
 This class is a representation of a temporary place.
 It presents the same behavior as a context place, however is different
 in that it can only be marked during an activation or a deactivation
 but not after
 */

@interface PNTemporaryPlace : PNPlace {
    
}

@end
