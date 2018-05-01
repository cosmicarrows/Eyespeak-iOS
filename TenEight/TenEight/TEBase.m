//
//  TEBase.m
//  TenEight
//
//  Created by Kennedy Kok on 8/25/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEBase.h"

@implementation TEBase

@synthesize delegate;


-(void) serviceDidSucceed:(TEBase*) object
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(serviceDidSucceed:)])
    {
        [delegate serviceDidSucceed:object];
    }
}

-(void) serviceDidFail:(TEBase*) object
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(serviceDidFail:)])
    {
        [delegate serviceDidFail:object];
    }
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didFail:)])
    {
        [delegate didFail:error];
    }
}




@end
