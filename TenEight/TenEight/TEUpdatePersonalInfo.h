//
//  TEUpdatePersonalInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEUpdatePersonalInfo : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TELoginInfo* UpdatePersonalInfoInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
