//
//  TEDocumentProxy.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/25/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEDocumentProxy.h"

@implementation TEDocumentProxy

#pragma mark Proxy Interface methods

- (NSData *)getDocument:(NSInteger)documentID
{
    NSData *document = [self getDocumentFromCache:documentID];
    
    if (!document) {
        if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
            TEDocumentInfo *documentInfo = [self getDocumentInfo:documentID];
            if (documentInfo) {
                NSString *documentURL = documentInfo.document;
                document = [NSData dataWithContentsOfURL:[NSURL URLWithString:documentURL]];
                [self storeDocumentInCache:document withID:documentID];
            }
        } else {
            // not in cache, and we are offline.
            document = nil;
        }
        
    }
    
    return document;
    
}

- (NSString *)getPathForDocument:(NSInteger)documentID
{
    [self getDocument:documentID]; //ensure the document is cached
    
    TEDocumentInfo *documentInfo = [self getDocumentInfo:documentID];
    if (documentInfo) {
        NSArray *parts = [documentInfo.document componentsSeparatedByString:@"."];
        NSString *extension = [[parts lastObject] lowercaseString];
        NSString *path = [self getDirName];
        NSString *filename = [NSString stringWithFormat:@"%d.%@",documentID, extension];
        path = [path stringByAppendingPathComponent:filename];
        
        return path;
    }
    return @"";

}


#pragma mark Helpers

- (TEDocumentInfo *)getDocumentInfo:(NSInteger)documentID
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"TEDocumentInfo" inManagedObjectContext:[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"documentID = %d", documentID];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fdocuments = [[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread executeFetchRequest:fetchRequest error:&error];
    
    if (fdocuments && ([fdocuments count]>=1)) {
        return [fdocuments objectAtIndex:0];
    }
    
    return nil;
}

- (NSData *)getDocumentFromCache:(NSInteger)documentID
{
    TEDocumentInfo *documentInfo = [self getDocumentInfo:documentID];
    if (documentInfo) {
        NSArray *parts = [documentInfo.document componentsSeparatedByString:@"."];
        NSString *extension = [[parts lastObject] lowercaseString];
        NSString *path = [self getDirName];
        NSString *filename = [NSString stringWithFormat:@"%d.%@",documentID, extension];
        path = [path stringByAppendingPathComponent:filename];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            //File exists
            NSData *document = [[NSData alloc] initWithContentsOfFile:path];
            if (document)
            {
                return document;
                
            }
        }
        else
        {
            DDLogVerbose(@"File does not exist");
        }
    }
    
    return nil;
    
    
}

- (NSString *)getDirName
{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"com.eyespeak.teneight.docs"];
	NSError *error;
	if (![[NSFileManager defaultManager] fileExistsAtPath:path])	//Does directory already exist?
	{
		if (![[NSFileManager defaultManager] createDirectoryAtPath:path
									   withIntermediateDirectories:NO
														attributes:nil
															 error:&error])
		{
			DDLogVerbose(@"Create directory error: %@", error);
		}
	}
    return path;
}

- (void)storeDocumentInCache:(NSData *)document withID:(NSUInteger)documentID
{
    TEDocumentInfo *documentInfo = [self getDocumentInfo:documentID];
    if (documentInfo) {
        NSArray *parts = [documentInfo.document componentsSeparatedByString:@"."];
        NSString *extension = [[parts lastObject] lowercaseString];
        NSString *path = [self getDirName];
        NSString *filename = [NSString stringWithFormat:@"%d.%@",documentID, extension];
        path = [path stringByAppendingPathComponent:filename];
        [document writeToFile:path atomically:YES];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.1")) {
            [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
        }
    }
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        DDLogVerbose(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

-(void)stopProcessing
{
//    [[[[RKObjectManager sharedManager] client] requestQueue] cancelRequestsWithDelegate:self];
}

- (void)dealloc {
    [self stopProcessing];
}

@end
