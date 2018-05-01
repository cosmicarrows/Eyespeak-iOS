//
//  TEUpdatePreferences.h
//  TenEight
//
//  Created by Kennedy Kok on 8/20/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEUpdatePreferences : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* UpdatePreferencesInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
