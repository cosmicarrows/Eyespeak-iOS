//
//  TEGetDetailsForBuilding.h
//  TenEight
//
//  Created by Kennedy Kok on 8/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEDetailsForBuilding.h"


@interface TEGetDetailsForBuilding : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TEDetailsForBuilding* GetDetailsForBuildingInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
