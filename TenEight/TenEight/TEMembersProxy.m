//
//  TEMembersProxy.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEMembersProxy.h"

@implementation TEMembersProxy

@synthesize delegate;
@synthesize tourID;


#pragma mark Proxy Interface methods

- (void)loadMembersInTour:(NSInteger)_tourID
{
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        self.tourID = _tourID;
        
        NSString *callString = [NSString stringWithFormat:@"/GetMembersInTour/%@/%d", theAppDelegate().token, self.tourID];
        
        DDLogVerbose(@"TEMembersProxy loadMembersInTour: %@",callString);
        
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        [objectManager loadObjectsAtResourcePath:callString delegate:self];
    } else {
        //we can have caller read this from db
        if ([self.delegate respondsToSelector:@selector(membersLoaded:withMessage:)]) {
            [self.delegate membersLoaded:YES withMessage:nil];
        }
    }

}



- (void)deleteMember:(NSString *)memberID fromTour:(NSInteger)_tourID
{
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        NSString *callString = [NSString stringWithFormat:@"/RemoveUserFromTour/%@/%d/%@", theAppDelegate().token, _tourID, memberID];
        
        DDLogVerbose(@"TEMembersProxy deleteMember fromTour: %@",callString);
        
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        [objectManager loadObjectsAtResourcePath:callString delegate:self];
    } else {
        if ([self.delegate respondsToSelector:@selector(memberDeleted:withMessage:)]) {
            [self.delegate memberDeleted:NO withMessage:@"Cannot delete a member when offline."];
        }
    }
}




#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
{
    DDLogVerbose(@"TEMembersProxy didLoadResponse: %@", [response bodyAsString]);

    NSDictionary* d = [response parsedBody:nil];
    
    NSDictionary* GetMembersInTourInfo = [d objectForKey:@"GetMembersInTourInfo"];
    
    if (GetMembersInTourInfo)
    {
        
        NSString *resourcePath = [request resourcePath];
        NSArray *parts = [resourcePath componentsSeparatedByString:@"/"];
        NSString *tid = [parts lastObject];
        
        NSError* error;
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"TETourMember" inManagedObjectContext:[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread];
        [fetchRequest setEntity:entity];

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tourId = %@", tid];
        [fetchRequest setPredicate:predicate];

        NSArray *fmembers = [[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread executeFetchRequest:fetchRequest error:&error];
        
        for (TETourMember * m in fmembers)
        {
            [[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread deleteObject:m];
        }
        
        
        [[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread save:&error];
        
    }

}


- (void)objectLoader:(RKObjectLoader *)loader willMapData:(inout id *)mappableData
{
    NSDictionary* d = (NSDictionary*) *mappableData;
    
    NSArray* mi = [d objectForKey:@"GetMembersInTourInfo"];
    
    if (mi)
    {
        NSMutableArray* ma = [NSMutableArray arrayWithArray:mi];
        
        for (int i= 0; i < ma.count; i++)
        {
            
            NSMutableDictionary* mbi = [NSMutableDictionary dictionaryWithDictionary:[ma objectAtIndex:i]];
            
            [mbi setObject:[NSNumber numberWithInt:self.tourID] forKey:@"tourId"];
            
            [ma replaceObjectAtIndex:i withObject:mbi];
        }
        
        NSMutableDictionary* md = [NSMutableDictionary dictionaryWithDictionary:d];
        [md setObject:ma forKey:@"GetMembersInTourInfo"];
        
        *mappableData = md;
        
    }
    
}



- (void)objectLoader:(RKObjectLoader*)objectLoader didFailLoadWithError:(NSError*)error {
    DDLogVerbose(@"TEMembersProxy didFailLoadWithError: %@", error);
    if ([self.delegate respondsToSelector:@selector(objectLoader:didFailWithError:)]) {
        [self.delegate objectLoader:objectLoader didFailWithError:error];
    }
}


- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    DDLogVerbose(@"TEMembersProxy didFailWithError: %@", error);
    if ([self.delegate respondsToSelector:@selector(objectLoader:didFailWithError:)]) {
        [self.delegate objectLoader:objectLoader didFailWithError:error];
    }
}


- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    DDLogVerbose(@"TEMembersProxy didLoadObjects");
    
    DDLogVerbose (@"TEMembersProxy %@",[[objects objectAtIndex:0] class]);
    
    if ([[objects objectAtIndex:0] isKindOfClass:[TEGetMembersInTour class]])
    {
        TEGetMembersInTour* response = (TEGetMembersInTour*) [objects objectAtIndex:0];
        if (!(response.responseStatus.status == 1))
        {
            NSString *errors = response.responseStatus.response;
            for (TEDetailedErrorMessageInfo *info in response.detailedErrorMessage) {
                errors = [NSString stringWithFormat:@"%@\n%@",errors,info.msg];
            }
            if ([self.delegate respondsToSelector:@selector(membersLoaded:withMessage:)]) {
                [self.delegate membersLoaded:NO withMessage:errors];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(membersLoaded:withMessage:)]) {
                [self.delegate membersLoaded:YES withMessage:nil];
            }
        }
    }
    
    if ([[objects objectAtIndex:0] isKindOfClass:[TERemoveUserFromTour class]])
    {
        TERemoveUserFromTour* response = (TERemoveUserFromTour*) [objects objectAtIndex:0];
        if (!(response.responseStatus.status == 1))
        {
            NSString *errors = response.responseStatus.response;
            for (TEDetailedErrorMessageInfo *info in response.detailedErrorMessage) {
                errors = [NSString stringWithFormat:@"%@\n%@",errors,info.msg];
            }
            if ([self.delegate respondsToSelector:@selector(memberDeleted:withMessage:)]) {
                [self.delegate memberDeleted:NO withMessage:errors];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(memberDeleted:withMessage:)]) {
                [self.delegate memberDeleted:YES withMessage:nil];
            }
        }
    }
    
}


-(void)stopProcessing
{
    [[[[RKObjectManager sharedManager] client] requestQueue] cancelRequestsWithDelegate:self];
    [[RKClient sharedClient].requestQueue cancelRequestsWithDelegate:self];
}

#pragma mark Management methods
- (id) init {
    self = [super init];
    if(self) {
        // any init necessary
    }
    return self;
}

- (void)dealloc {
    [self stopProcessing];
}


@end
