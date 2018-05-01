//
//  TEPhotoProxy.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEPhotoProxyDelegate <NSObject>
@optional
- (void)photoPosted:(BOOL)success withPhotoID:(NSInteger)photoID withMessage:(NSString *)message;
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error;
@end


@interface TEPhotoProxy : TEProxyBase <RKObjectLoaderDelegate>

enum PhotoTypes {
    PhotoTypeThumb,
    PhotoTypeLarge
};

@property (nonatomic, weak) id<TEPhotoProxyDelegate> delegate;

- (void)postPhotoWithParams:(RKParams *)params;
- (NSData *)getPhoto:(NSInteger)photoID ofType:(NSUInteger)photoType;
- (void)stopProcessing;

@end


