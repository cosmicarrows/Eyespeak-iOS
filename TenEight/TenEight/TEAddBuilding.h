//
//  TEAddBuilding.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/19/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEDetailsForBuilding.h"

@interface TEAddBuilding : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TEDetailsForBuilding* GetDetailsForBuildingInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
