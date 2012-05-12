//
//  PNEFileManager.m
//  Petri Net Editor
//
//  Created by Mathijs Saey on 12/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import "PNEFileManager.h"

@implementation PNEFileManager

#pragma mark - Lifecycle

- (id) init {
    if (self = [super init]) {
        //Get the documents directory
        NSArray *dirList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        basePath = [NSString stringWithFormat:@"%@/",[dirList objectAtIndex:0]];
        currentPath = [[NSString alloc] initWithString:basePath];
    }
    return self;
}

- (void) dealloc {
    [basePath release];
    [currentPath release];
    [super dealloc];
}

#pragma mark - Directory commands

/**
 This method moves to a folder in the current directory
 it's the equivalent of cd <name>
 @param folderName
    The name of the folder
 */
- (void) changeFolder: (NSString*) folderName {
    currentPath = [currentPath stringByAppendingString:[NSString stringWithFormat:@"/%@", folderName]];
}

/**
 This method returns to the higher folder
 it's the equivalent of cd ..
 */
- (void) returnToFolder {
    if (![currentPath isEqualToString:basePath]){
        NSRange pathRange = [currentPath rangeOfString:@"/" options:NSBackwardsSearch];
        currentPath = [currentPath substringToIndex:pathRange.location + 1];
    }    
}

- (void) newFolder: (NSString*) folderName {
    
}

/**
 This function returns the content of a folder as 
 an array
 */
- (NSArray*) getFolderContent {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:currentPath error:nil];
    [manager release];
    
    return fileList;
}

#pragma mark - File opening

/**
 This function returns the contents of a contextdeclaration
 file as a string.
 @param name
 The name of the file
 */
- (NSString*) getContextDeclaration: (NSString*) name {
    NSFileHandle *contextFile = [NSFileHandle fileHandleForReadingAtPath:[currentPath stringByAppendingString:name]];
    NSData *buffer = [contextFile readDataToEndOfFile];
    
    NSString *contents = [[NSString alloc] initWithData:buffer encoding:NSASCIIStringEncoding];
    
    [contextFile closeFile];    
    return contents;
}

@end
