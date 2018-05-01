//
//  TEBuildingRentalInfo.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEBuildingRentalInfo : NSManagedObject

@property (strong, nonatomic) NSNumber* buildingID;
@property (strong, nonatomic) NSNumber* tourID;
@property (strong, nonatomic) NSNumber* rentableSqFt;
@property (strong, nonatomic) NSNumber* rentalRate;

@end