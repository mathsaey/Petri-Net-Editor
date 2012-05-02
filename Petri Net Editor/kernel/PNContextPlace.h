//
//  PnplacePlace.h
//  place
//
//  Created by NicolasCardozo on 20/03/12.
//  Copyright 2012 Université catolique de Louvain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPlace.h"

@class PNToken;

@interface PNContextPlace : PNPlace {

}

///------------------------------------------------------------
/// @name place Data
///------------------------------------------------------------

///------------------------------------------------------------
/// @name Initialization & Disposal
///------------------------------------------------------------

/** Initialize a place with a specific name.
 @param placeName The name of the place to initialize.
 @return The initialized place.
 */
- (id)initWithName:(NSString *)placeName;

/** Initialize a place with a specific name.
 @param placeName The name of the place to initialize.
 @param newCapacity The activation bound of the place
 @return The initialized place.
 */
- (id) initWithName:(NSString *) newName AndCapacity: (int) newCapacity;


@end
