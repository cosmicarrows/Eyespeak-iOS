//
//  TELogin.m
//  TenEight
//
//  Created by Kennedy Kok on 8/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TELogin.h"
#import <CommonCrypto/CommonDigest.h>


@implementation TELogin

@synthesize responseStatus;
@synthesize LoginInfo;


- (NSString*)MD5:(NSString*) str
{
    // Create pointer to the string as UTF8
    const char *ptr = [str UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

-(void) doDBInit:(NSString*) dbName
{
    //initialize DB - each user get's his or her own DB based on email address
    [theAppDelegate() initObjectManager:[NSString stringWithFormat:@"%@.sqlite", dbName] ];
    
    [super serviceDidSucceed:self];
    
}



- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    BOOL success = false;
    if ((objects!= nil) && (objects.count > 0))
    {
        if ([[objects objectAtIndex:0] isKindOfClass:[TELogin class]])
        {
            TELogin* login = (TELogin*) [objects objectAtIndex:0];
            
            self.responseStatus = login.responseStatus;
            self.LoginInfo = login.LoginInfo;
            
            //success
            if (self.responseStatus.status == 1)
            {
                success = true;
                DDLogVerbose(@"login success");
                theAppDelegate().masterUserLoginInfo = login.LoginInfo;
                theAppDelegate().token = login.LoginInfo.token;
            
                [self performSelector:@selector(doDBInit:) withObject:login.LoginInfo.email afterDelay:0.1];
            }

        }
    }
    if (!success) {
        [super serviceDidFail:self];
    }

}


-(void) login:(NSString*) email password:(NSString*) pw typeOfUser:(int) type
{
    
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        
        if (type == TEUserPro) {
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"/Login/PRO/%@/%@", email, [self MD5:pw]] delegate:self];
        } else {
            //tenant
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"/Login/TENANT/%@", email] delegate:self];
        }
    } else {
        TELogin *response = [[TELogin alloc] init];
        TEStatus *status = [[TEStatus alloc] init];
        status.response = @"No network connection.  Cannot login.";
        response.responseStatus = status;
        [self serviceDidFail:response];
    }


}
@end
