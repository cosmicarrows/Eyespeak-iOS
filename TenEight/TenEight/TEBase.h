//
//  TEBase.h
//  TenEight
//
//  Created by Kennedy Kok on 8/25/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TEBaseDelegate;

@interface TEBase : NSObject <RKObjectLoaderDelegate>

-(void) serviceDidSucceed:(TEBase*) object;
-(void) serviceDidFail:(TEBase*) object;
@property(nonatomic,assign) id<TEBaseDelegate> delegate;
@end

/**
 Lifecycle events for an RKRequest object
 */
@protocol TEBaseDelegate <NSObject>
-(void) serviceDidSucceed:(id) object;
-(void) serviceDidFail:(id) object;
-(void) didFail:(id) object;

@optional

@end