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
 
 This class is responsible for opening
 and writing the various files the editor uses.
 */
@interface PNEFileManager : NSObject {
    NSString *basePath;
    NSString *currentPath;
}

-(void) putContextDeclaration: (NSString*) fileName withContents: (NSString*) contents;
- (NSData*) getContextDeclarationBuffer: (NSString*) name;
- (NSString*) getContextDeclaration: (NSString*) name;
- (BOOL) isContextDeclaration: (NSString*) name;
- (BOOL) parseFile: (NSString*) name;

- (void) changeFolder: (NSString*) folderName;
- (NSArray*) getFolderContent;
- (void) returnToFolder;

@end
