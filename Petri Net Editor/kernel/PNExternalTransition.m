//
//  PNExternalTransition.m
//  context
//
//  Created by NicolasCardozo on 18/03/12.
//  Copyright 2012 Université catolique de Louvain. All rights reserved.
//

#import "PNExternalTransition.h"


@implementation PNExternalTransition

- (id)init {
    self = [super init];
    if (self) {
        priority = EXTERNAL;
    }
    
    return self;
}

- (id) initWithName:(NSString *) newName {
    self = [super initWithName:newName];
    [self setEnabled: YES];
    [self setPriority: EXTERNAL];
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL) checkEnabledWithColor:(NSNumber *)color {
    return YES;
}

-(void) fireWithColor:(NSNumber *)color {
    int flow;
    for(PNPlace *outp in [outputs keyEnumerator]) {
        flow = [[outputs objectForKey:outp] flowFunction];
        PNToken *tok = [outp getTokenOfColor:color];
        if(tok != nil) {
            [tok setValue:([tok value] + flow)];
        } else {
            tok = [[[PNToken alloc] init] autorelease];
            [tok setValue:flow];
            [tok setColor:color];
            [[outp tokens] addObject:tok]; 
        }
	}

}
@end
