//
//  TEGetPersonalInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEPersistentLoginInfo.h"


@interface TEGetPersonalInfo : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TEPersistentLoginInfo* GetPersonalInfoInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
