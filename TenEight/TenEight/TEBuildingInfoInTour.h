//
//  TEBuildingInfoInTour.h
//  TenEight
//
//  Created by Kennedy Kok on 8/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEBuildingInfoInTour : NSManagedObject

@property (strong, nonatomic) NSNumber* responseOrder;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* zipCode;
@property (strong, nonatomic) NSNumber* myScore;
@property (strong, nonatomic) NSNumber* groupScore;
@property (strong, nonatomic) NSNumber* globalScore;
@property (strong, nonatomic) NSNumber* buildingID;
@property (strong, nonatomic) NSNumber* key;
@property (strong, nonatomic) NSNumber* tourID;
@property (strong, nonatomic) NSNumber* imageID;
@property (strong, nonatomic) NSString* thumbImage;
@property (strong, nonatomic) NSString* largeImage;
@end
    