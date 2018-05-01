//
//  TEBuilding.h
//  TenEight
//
//  Created by Kennedy Kok on 8/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEBuildingInfo : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* zipCode;
@property (strong, nonatomic) NSNumber* myScore;
@property (strong, nonatomic) NSNumber* groupScore;
@property (strong, nonatomic) NSNumber* globalScore;
@property (strong, nonatomic) NSNumber* buildingID;

@end
