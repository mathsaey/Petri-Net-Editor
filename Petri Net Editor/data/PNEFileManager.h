//
//  PNEFileManager.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 12/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @author Mathijs Saey
 
 This class is responsible for opening
 and writing the various files the editor uses.
 */
@interface PNEFileManager : NSObject {
    NSString *basePath;
    NSString *currentPath;
}

- (NSString*) getContextDeclaration: (NSString*) name;

- (void) changeFolder: (NSString*) folderName;
- (void) returnToFolder;
- (NSArray*) getFolderContent;

@end
