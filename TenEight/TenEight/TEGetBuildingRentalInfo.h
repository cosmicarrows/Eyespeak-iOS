//
//  TEGetBuildingRentalInfo.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEBuildingRentalInfo.h"

@interface TEGetBuildingRentalInfo : NSObject


@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TEBuildingRentalInfo* GetBuildingRentalInfoInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
