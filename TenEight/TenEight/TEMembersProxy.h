//
//  TEMembersProxy.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TEMembersProxyDelegate <NSObject>
@optional
- (void)membersLoaded:(BOOL)success withMessage:(NSString *)message;
- (void)memberDeleted:(BOOL)success withMessage:(NSString *)message;
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error;
@end



@interface TEMembersProxy : TEProxyBase <RKObjectLoaderDelegate>

@property (nonatomic, weak) id<TEMembersProxyDelegate> delegate;
@property (nonatomic) NSInteger tourID;

- (void)loadMembersInTour:(NSInteger)tourID;
- (void)deleteMember:(NSString *)memberID fromTour:(NSInteger)tourID;
- (void)stopProcessing;

@end


