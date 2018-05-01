//
//  TEPhotoProxy.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEDocumentProxyDelegate <NSObject>
// no known delegate methods at moment
@end


@interface TEDocumentProxy : TEProxyBase



@property (nonatomic, weak) id<TEDocumentProxyDelegate> delegate;

- (NSData *)getDocument:(NSInteger)documentID;
- (NSString *)getPathForDocument:(NSInteger)documentID;
- (void)stopProcessing;

@end


