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
        basePath = [[dirList objectAtIndex:0] retain];
        currentPath = [[NSString alloc] initWithString:basePath];
    }
    return self;
}

- (void) dealloc {
    //[basePath release];
    //[currentPath release];
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
    currentPath = [currentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", folderName]];
    [currentPath retain];
}

/**
 This method creates a new directory in the current directory
 @param folderName
    The name of the new folder
 */
- (void) addFolder: (NSString*) folderName {
    NSFileManager *manager =[NSFileManager defaultManager];
    [manager createDirectoryAtPath:[currentPath stringByAppendingPathComponent:folderName]withIntermediateDirectories:false attributes:nil error:nil];
}

/**
 This method returns to the higher folder
 it's the equivalent of cd ..
 */
- (void) returnToFolder {
    if (![currentPath isEqualToString:basePath]){
        currentPath = [currentPath stringByDeletingLastPathComponent];
        [currentPath retain];
    }    
}

/**
 This method creates an array with the files or folders 
 of a folder.
 @param getFolders
    True if the method needs to return the folders
 @return
    An NSArray with all the folders of the current directory
    if getFolders is true. An NSArray with all the files of the
    directory otherwise.
 */
- (NSArray*) getFolder: (BOOL) getFolders {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *dirList = [manager contentsOfDirectoryAtPath:currentPath error:nil];
    NSMutableArray *resList = [[NSMutableArray alloc] init];
    
    for (NSString*  name in dirList) {
        BOOL isDir;
        BOOL exists = [manager fileExistsAtPath:[currentPath stringByAppendingPathComponent:name] isDirectory:&isDir];
        
        if (exists && isDir && getFolders)
            [resList addObject:name];
        else if (exists && !isDir && !getFolders)
            [resList addObject:name];
    }
    [resList autorelease];
    return resList;
}

/**
 This method returns an array with al the 
 files in the current directory.
 @see getFolder
 @return 
    An array with all the files 
    in the current directory.
 */
- (NSArray*) getFilesInFolder {
    return [self getFolder:false];
}

/**
 This method returns an array with al the 
 folders in the current directory.
 @see getFolder
 @return 
    An array with all the folders 
    in the current directory.
 */
- (NSArray*) getFoldersInFolder {
    return [self getFolder:true];
}

#pragma mark - File management

/**
 This method deletes an element
 @param name
    The name of the element.
 */
- (void) eraseElement: (NSString*) name {
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[currentPath stringByAppendingPathComponent:name] error:nil];
}

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
    NSFileHandle *contextFile = [NSFileHandle fileHandleForReadingAtPath:[currentPath stringByAppendingPathComponent:name]];
    NSData *buffer = [contextFile readDataToEndOfFile];
    
    NSString *contents = [[NSString alloc] initWithData:buffer encoding:NSASCIIStringEncoding];
    
    [contextFile closeFile];
    [contents autorelease];
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
    NSFileHandle *contextFile = [NSFileHandle fileHandleForReadingAtPath:[currentPath stringByAppendingPathComponent:name]];
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
    NSString *pathName = [[currentPath stringByAppendingPathComponent:fileName] retain];
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
    [pathName release];
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
