//
//  TETourInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/20/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TETourInfo : NSManagedObject


@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSNumber* tourID;
@property (strong, nonatomic) NSString* tourType;
@property (strong, nonatomic) NSNumber* memberCount;
@property (strong, nonatomic) NSNumber* buildingCount;
@property (strong, nonatomic) NSString* createdOn;

@end
