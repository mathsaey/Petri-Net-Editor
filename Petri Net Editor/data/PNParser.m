//
//  PNParser.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 9/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNParser.h"

@implementation PNParser

- (id) init {
    if (self = [super init]) {
        didFinishWithoutErrors = true;
        contexts = [[NSMutableDictionary alloc] init];
        manager = [PNManager sharedManager];
        state = NO_STATE;
    }
    return self;
}

- (void) dealloc {
    [contexts release];
    [super dealloc];
}

#pragma mark - Help methods

/**
 This method prints an error
 when something goes wrong during 
 the parsing of the .sc file.
 This method should be adjusted
 if this parser will be ported
 @param errorMessage
    The message to present to the user
 */
- (void) printError: (NSString*) errorMessage {
    state = END_STATE;
    didFinishWithoutErrors = false;
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR_WINDOW_TITLE", nil) message:errorMessage delegate:self cancelButtonTitle:NSLocalizedString(@"OK_BUTTON", nil) otherButtonTitles: nil];
    [error show];
    [error release];
}

/**
 This method removes all the spaces 
 at the start and end of a string.
 @param string
    The string that needs to be edited
 @return
    The string without spaces in front or behind it
 */
- (NSString*) removeSpaces: (NSString*) string {
    while ([string hasPrefix:@" "]) {
        string = [string substringFromIndex:1];
    }
    while ([string hasSuffix:@" "]) {
        string = [string substringToIndex:[string length] - 1];
    }
    return string;
}

/**
 This method looks for spaces in a string
 @param string
    The string that could contain spaces
 @return 
 */
- (BOOL) containsSpaces: (NSString*) string {
    NSRange spaceLoc = [string rangeOfString:@" "];
    return spaceLoc.location != NSNotFound;
}

#pragma mark - Parse functionality

/**
 This method starts the parsing,
 it simply calls parseline for each line
 
 @param contextDeclaration
    The full contextDeclaration string to parse
 @return
    True if the parser finished without errors
 */
- (BOOL) parse: (NSString*) contextDeclaration {  
    [PNManager trashManager];
    didFinishWithoutErrors = true;
    for (NSString *line in [contextDeclaration componentsSeparatedByString:@"\n"]) {
        if (state == END_STATE) return didFinishWithoutErrors;
        [self parseLine:line];
    } 
    return didFinishWithoutErrors;
}

/**
 This method parses a single line of the 
 contextdeclaration, it checks for comments,
 empty lines and new state identifiers.
 Afterwards it passes on the line to the 
 responsible method.
 @param line the line to parse
 */
- (void) parseLine: (NSString*) line {
    //Filter out the comments
    NSRange commentRange = [line rangeOfString:NSLocalizedStringFromTable(@"COMMENT_TOKEN", @"parser", nil)];
    if (commentRange.location != NSNotFound) {
        commentRange.length = commentRange.length - 1;
        line = [line substringToIndex:commentRange.location];
    }
        
    //Filter out the empty lines
    if([line isEqualToString:@""]) return;
    
    //See if the state should be changed
    if ([self checkStateChange:line]) return;

    switch (state) {
        case NO_STATE:
            [self parseNoState:line];
            break;
        case PARSING_CONTEXTS:
            [self parseContext:line];
            break;
        case PARSING_LINKS:
            [self parseLink:line];
            break;
        case END_STATE:
            return;
            break;
    }
}

/**
 This method checks for lines that change the 
 state of the parser.
 @param line
    The line to check
 @return
    True if the state changed, false if it didn't
 */
- (BOOL) checkStateChange: (NSString*) line {
    line = [self removeSpaces:line];
    if ([line isEqualToString:NSLocalizedString(@"CONTEXT_INDICATOR", nil)]) state = PARSING_CONTEXTS;
    else if ([line isEqualToString:NSLocalizedString(@"LINK_INDICATOR", nil)]) state = PARSING_LINKS;
    else if ([line isEqualToString:NSLocalizedString(@"END_INDICATOR", nil)]) state = END_STATE;
    else return false;
    return true;
}

/**
 Parses a line when the parser is in the 
 NO_STATE.
 @param line
    The line to be parsed.
 */
- (void) parseNoState: (NSString*) line {
    [self printError:[NSString stringWithFormat:NSLocalizedString(@"NO_STATE_ERROR", nil), line]];
}

/**
 Parses a line when the parser is in the 
 PARSING_CONTEXTS state.
 The created context gets stored in a dictionary
 @param line
    The line to be parsed.
 */
- (void) parseContext: (NSString*) line {
    NSArray *components = [line componentsSeparatedByString:NSLocalizedString(@"CONTEXT_SEPERATOR", nil)];
    
    //Standard context creation
    if ([components count] == 1) {
        line = [self removeSpaces:line];
        if ([self containsSpaces:line]) {
            [self printError:[NSString stringWithFormat:NSLocalizedString(@"CONTEXT_NAME_HAS_SPACES", nil), line]];
            return;
        }
        [contexts setObject:[manager addPlaceWithName:line] forKey:line];
    }
    
    //Context with capacity
    else if ([components count] == 2) {
        NSString *contextName = [components objectAtIndex:0];
        NSString *contextCapacity = [components objectAtIndex:1];
        
        //Get the number from the string
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *capacity = [formatter numberFromString:contextCapacity];
        [formatter release];
        
        if (capacity == nil) {
            [self printError:[NSString stringWithFormat:NSLocalizedString(@"CAPACITY_NO_NUMBER", nil), contextCapacity]];
            return;  
        }
        if ([self containsSpaces:contextName]) {
            [self printError:[NSString stringWithFormat:NSLocalizedString(@"CONTEXT_NAME_HAS_SPACES", nil), contextName]];
            return;
        }
        [contexts setObject:[manager addPlaceWithName:contextName AndCapacity:[capacity intValue]] forKey:contextName];
    }
    
    else [self printError:[NSString stringWithFormat:NSLocalizedString(@"CONTEXT_SEPERATOR_AMOUNT", nil), line]];    
}

/**
 Parses a line when the parser is in the 
 PARSING_LINKS state.
 @param line
 The line to be parsed.
 */
- (void) parseLink: (NSString*) line {
    //Ensure the only spaces are inbetween the components
    line = [self removeSpaces:line];
    NSArray *components = [line componentsSeparatedByString:@" "];
    
    if ([components count] != 3)
        return [self printError:[NSString stringWithFormat:NSLocalizedString(@"LINK_DECLARATION_SPACE_AMOUNT", nil), line]];
    
    //Get the components
    NSString *fromContextName = [components objectAtIndex:0];
    NSString *toContextName = [components objectAtIndex:2];
    NSString *operator = [components objectAtIndex:1];
        
    PNPlace* fromContext = [contexts objectForKey:fromContextName];
    PNPlace* toContext = [contexts objectForKey:toContextName];
        
    if (fromContext == nil) return [self printError:[NSString stringWithFormat:NSLocalizedString(@"LINK_CONTEXT_NOT_FOUND", nil), fromContextName]];
    else if (toContext == nil) return [self printError:[NSString stringWithFormat:NSLocalizedString(@"LINK_CONTEXT_NOT_FOUND", nil), toContextName]];
    
    //Add the correct relation
    if ([operator isEqualToString:NSLocalizedString(@"WEAK_INCLUSION_TOKEN", nil)]) 
        return [manager addWeakInclusionFrom:fromContext To:toContext];
    else if ([operator isEqualToString:NSLocalizedString(@"STRONG_INCLUSION_TOKEN", nil)]) 
        return [manager addStrongInclusionFrom:fromContext To:toContext];
    else if ([operator isEqualToString:NSLocalizedString(@"EXCLUSION_TOKEN", nil)]) 
        return [manager addExclusionBetween:fromContext and:toContext];
    else if ([operator isEqualToString:NSLocalizedString(@"REQUIREMENT_TOKEN", nil)]) 
        return [manager addRequirementTo:fromContext Of:toContext];
    else return [self printError:[NSString stringWithFormat:NSLocalizedString(@"LINK_TOKEN_NOT_FOUND", nil), line, operator]];
}


@end
