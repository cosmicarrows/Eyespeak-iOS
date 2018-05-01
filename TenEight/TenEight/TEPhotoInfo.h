//
//  TEPhotoInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEPhotoInfo : NSManagedObject

@property (strong, nonatomic) NSString* large;
@property (strong, nonatomic) NSString* thumb;
@property (strong, nonatomic) NSNumber* buildingId;
@property (strong, nonatomic) NSNumber* photoID;
@property (strong, nonatomic) TEDetailsForBuilding* building;

@end
