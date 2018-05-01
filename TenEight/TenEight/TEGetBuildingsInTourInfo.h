//
//  TEGetBuildingsInTourInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEGetBuildingsInTourInfo : NSObject


@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* GetBuildingsInTourInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;


@end
