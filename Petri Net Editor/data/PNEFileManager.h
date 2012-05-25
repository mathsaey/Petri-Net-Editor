//
//  PNEFileManager.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 12/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNParser.h"

/**
 @author Mathijs Saey
 
 This class provides an abstraction layer for
 iOS file handling specific to the application.
 */
@interface PNEFileManager : NSObject {
    NSString *basePath; /**< Path that leads to the application document folder */
    NSString *currentPath; /**< Path to the current file/directory */
}

- (void) putContextDeclaration: (NSString*) fileName withContents: (NSString*) contents;
- (NSData*) getContextDeclarationBuffer: (NSString*) name;
- (NSString*) getContextDeclaration: (NSString*) name;
- (BOOL) isContextDeclaration: (NSString*) name;

- (BOOL) parseFile: (NSString*) name;
- (void) eraseElement: (NSString*) name;

- (void) changeFolder: (NSString*) folderName;
- (void) addFolder: (NSString*) folderName;
- (void) returnToFolder;

- (NSArray*) getFoldersInFolder;
- (NSArray*) getFilesInFolder;

@end
