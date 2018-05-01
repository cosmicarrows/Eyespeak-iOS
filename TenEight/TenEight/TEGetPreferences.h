//
//  TEGetPreferences.h
//  TenEight
//
//  Created by Kennedy Kok on 8/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEGetPreferences : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* GetPreferencesInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
