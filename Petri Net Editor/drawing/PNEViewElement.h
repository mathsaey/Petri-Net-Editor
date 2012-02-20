//
//  PNEViewElement.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 20/02/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNEViewElement : NSObject{
    id element;
}

- (id) initWithElement: (id) pnElement;

@end
