/**
 Petri Net Kernel. Context-oriented programming for mobile devices
 Copyright (C) 2012  Nicolás Cardozo
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "PNManager.h"
#import "PNPlace.h"
#import "PNTransition.h"
#import "PNMarking.h"

@implementation PNManager (Updates)

- (BOOL)fireTransitionWithName:(NSString *)transitionLabel {
    NSArray *arr = [self enabledTransitionsWithName:transitionLabel];
    if([arr count] != 0) {
        PNTransition *t = [arr objectAtIndex:0];
        return [self fireTransition: t];
    }  
    return NO;
}

-(BOOL) fireTransitionWithName:(NSString *)transitionName InThread: (NSThread *) thread {
    NSArray *arr = [self enabledTransitionsWithName:transitionName];
    PNTransition *t = [arr objectAtIndex:0];
    return [self fireTransition:t InThread:thread];
}

-(BOOL) fireTransition:(PNTransition *)transition InThread: (NSThread *) thread {
    NSNumber *nextColor = [[[NSNumber alloc] initWithInt:[[[threadMapping allKeys] lastObject] intValue] +1] autorelease];
    if([[threadMapping allKeysForObject:thread] count] == 0) {
             if(![nextColor isGreaterThan:[[[NSNumber alloc] initWithInt:1] autorelease]])
            nextColor = [[[NSNumber alloc] initWithInt:2] autorelease];
        [threadMapping setObject:thread forKey:nextColor];
    }
    return [self fireTransition:transition WithColor: nextColor];
}

-(BOOL) fireTransition:(PNTransition *)transition WithColor: (NSNumber *) color {
    [transition fireWithColor:color];
    [self updateMarkingForColor:color];
    while([[[PNManager sharedManager] transitionQueue] count] != 0) {
        PNTransition *t = [[[PNManager sharedManager] transitionQueue] objectAtIndex:0];
        [t fireWithColor: color];
        [[[PNManager sharedManager] transitionQueue] removeObjectAtIndex:0];
        [self updateMarkingForColor:color];
        for(PNTransition *transition in transitions) 
            [transition checkEnabledWithColor: color];
    } //while([[[PNManager sharedManager] transitionQueue] count] != 0); 
    
    if([[PNManager sharedManager] isStable]) {
        [marking updateSystemState];
        return YES;
    }
    else {
        [marking revertOperation];
        [NSException raise:@"Context not available for operation" format:@"Reason: %@", [transition description]];
        return NO;
    }
}

/**
 * Fire a given transition, it must be checked if the transition is enabled or not
 * in order to fire. in case the transition is not enabled an error signal should be send
 **/
- (BOOL) fireTransition:(PNTransition *)transition {
    return [self fireTransition:transition WithColor:[[NSNumber alloc] initWithInt: 1]];
}

- (void) updateMarkingForColor: (NSNumber *) color {
    [marking clean];
    for(PNPlace *c in places) {
        if([[c tokens] count] > 0) {
            [marking addActiveContextToMarking:c];
        }
    }
    for(PNPlace *c in temporaryPlaces) {
        if([[c tokens] count] > 0) {
            [marking addActiveContextToMarking:c];
        }
    }
    [self enabledTransitionsForColor:color];
}

-(NSArray *) transitionsWithName:(NSString *)label {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *transition in transitions) {
        if([[transition label] isEqualToString:label]) {
            [result addObject:transition];
        }
    }
    return [result autorelease];    
}

-(NSArray *) transitionsForPlace: (NSString *) name {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *t in transitions) {
        if ([[t label] hasSuffix:name]) 
            [result addObject:t];
    }
    return ([result autorelease]);
}

- (NSArray *) incidentTransitionOf: (PNPlace *) place {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (PNTransition *t in transitions) {
        if([[[t inputs] allKeys] containsObject: place] || [[[t outputs] allKeys] containsObject:place] ){
            [result addObject:t];
        }   
    }
    return ([result autorelease]);
}

-(NSMutableArray *) enabledTransitionsForColor: (NSNumber *) color {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNTransition *transition in transitions) {
        if([transition checkEnabledWithColor:color]) {
            [result addObject:transition];
        }
    }
    [result sortUsingComparator: ^(id obj1, id obj2) {
        if ([[obj1 inhibitorInputs] count] < [[obj2 inhibitorInputs] count]) {
            return (NSComparisonResult)NSOrderedDescending;
        }        
        if ([[obj1 inhibitorInputs] count] > [[obj2 inhibitorInputs] count]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return [result autorelease];
}

-(NSMutableArray *) enabledTransitionsWithName:(NSString *)transitionLabel {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for(PNTransition *t in transitions) {
        if([[t label] isEqualToString:transitionLabel] && [t enabled]) {
            [results addObject:t];
        }
    } 
    [results sortUsingComparator: ^(id obj1, id obj2) {
        if ([[obj1 inhibitorInputs] count] < [[obj2 inhibitorInputs] count]) {
            return (NSComparisonResult)NSOrderedDescending;
        }        
        if ([[obj1 inhibitorInputs] count] > [[obj2 inhibitorInputs] count]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return ([results autorelease]);
}

@end
