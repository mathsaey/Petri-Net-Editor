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

/**
 This method creates a new folder
 @param folderName
    The name of the new folder
 */
- (void) newFolder: (NSString*) folderName {
    
}

/**
 This function returns the content of a folder as 
 an array
 @return 
    An array containing a string representation
    of the contents of the folder
 */
- (NSArray*) getFolderContent {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:currentPath error:nil];
    [manager release];
    
    return fileList;
}

#pragma mark - File management

/**
 This method opens a file and passes it on
 to the parser.
 @param name
    The name of the file
 @return
    True if the parser finished without errors
 */
- (BOOL) parseFile: (NSString*) name {
    PNParser *parser = [[PNParser alloc] init];
    BOOL didFinishWithoutReceivingErrors = [parser parse:[self getContextDeclaration:name]];
    [parser release];
    return didFinishWithoutReceivingErrors;
}

/**
 This function returns the contents of a contextdeclaration
 file as a string.
 @param name
    The name of the file
 @return 
    The context declaration
 */
- (NSString*) getContextDeclaration: (NSString*) name {
    NSFileHandle *contextFile = [NSFileHandle fileHandleForReadingAtPath:[currentPath stringByAppendingString:name]];
    NSData *buffer = [contextFile readDataToEndOfFile];
    
    NSString *contents = [[NSString alloc] initWithData:buffer encoding:NSASCIIStringEncoding];
    
    [contextFile closeFile];    
    return contents;
}

/**
 This function returns a data representation of a
 context declaration.
 @param name
    The name of the file
 @return 
    The data version of the context declaration
 */
- (NSData*) getContextDeclarationBuffer: (NSString*) name {
    NSFileHandle *contextFile = [NSFileHandle fileHandleForReadingAtPath:[currentPath stringByAppendingString:name]];
    NSData *buffer = [contextFile readDataToEndOfFile];
    [contextFile closeFile];    
    return buffer;
}

/**
 This function writes to a context declaration, if the
 file doesn't exist, a new file is created.
 @param fileName
    The name of the file
 @param contents
    The contents of the string to be written
 */
-(void) putContextDeclaration: (NSString*) fileName withContents: (NSString*) contents {
    NSString *pathName = [currentPath stringByAppendingString:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Create the data to write
    const char *cStrContents = [contents cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *buffer = [NSData dataWithBytes:cStrContents length:strlen(cStrContents)];
    
    //Open the file for writing, or create a new file
    if ([fileManager isWritableFileAtPath:pathName]) {
        //Delete the old data and write the new contents
        NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:pathName];
        [file truncateFileAtOffset:0];
        [file writeData:buffer];
        [file closeFile];
    }
    //Create a new file with the data
    else [fileManager createFileAtPath:pathName contents:buffer attributes:nil];
}

/**
 This function checks if a certain file is a context
 declaration, it only checks the extention of the file
 @param name
    The name of the file.
 @return 
    True if the file has the proper extention.
 */
- (BOOL) isContextDeclaration: (NSString*) name {
    return [name hasSuffix:@".sc"];
}

@end
