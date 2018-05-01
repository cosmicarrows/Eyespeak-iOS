//
//  TEStatus.h
//  TenEight
//
//  Created by Kennedy Kok on 8/8/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEStatus : NSObject

@property (assign, nonatomic) int status;
@property (assign, nonatomic) int errorcode;
@property (strong, nonatomic) NSString* response;

@end
