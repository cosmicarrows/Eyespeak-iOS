//
//  TEEditBuildingRentalInfo.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/19/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEEditBuildingRentalInfoInfo.h"

@interface TEEditBuildingRentalInfo : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TEEditBuildingRentalInfoInfo* EditBuildingRentalInfoInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
