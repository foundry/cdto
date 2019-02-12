//
//  CD2ITerm.m
//  iterm
//
//  Created by James Tuley on 2/18/07.
//  Copyright 2007 Jay Tuley. All rights reserved.
//

#import "CD2ITerm.h"

@implementation CD2ITerm
-(BOOL)openTermWindowForPath:(NSString*)aPath{
	@try{
        NSString* gitPath = [self findGitInPath:aPath];
        NSString* pathToOpen = gitPath ? gitPath : aPath;
        [[NSWorkspace sharedWorkspace] openFile:[pathToOpen stringByExpandingTildeInPath] withApplication:@"Sourcetree.app"];


	}@catch(id test){
		return NO;
	}
	return YES;
}


- (NSString*)findGitInPath:(NSString*)aPath {
    if ([aPath isEqualToString:@"/"]) {
        return nil;
    }
    if ([self gitRepoExists:aPath]) {
        return aPath;
    } else {
        aPath = [aPath stringByDeletingLastPathComponent];
        
        return [self findGitInPath:aPath];
    }
}
- (BOOL)gitRepoExists:(NSString*)aPath {
    NSString* gitComponent = @"/.git";
    if ([aPath.lastPathComponent isEqualToString:@"/"]) {
        gitComponent = @".git";
    }
    aPath = [aPath stringByAppendingString:gitComponent];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDiretory = YES;
    BOOL exists = [fileManager fileExistsAtPath:aPath isDirectory:&isDiretory];
    return exists;

}


@end
