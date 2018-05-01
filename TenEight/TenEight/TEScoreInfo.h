//
//  TEScoresInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEScoreInfo : NSManagedObject

@property (strong, nonatomic) NSNumber* attributeID;
@property (strong, nonatomic) NSString* attributeName;
@property (strong, nonatomic) NSNumber* score;
@property (strong, nonatomic) NSNumber* buildingId;
@property (strong, nonatomic) NSNumber* modified;
@property (strong, nonatomic) TEDetailsForBuilding* building;

@end
