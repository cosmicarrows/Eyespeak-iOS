//
//  TEDetailsForBuildingInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEDetailsForBuilding : NSManagedObject


@property (strong, nonatomic) NSNumber* buildingId;
@property (strong, nonatomic) NSString* notes;
@property (strong, nonatomic) NSNumber* rentalRate;
@property (strong, nonatomic) NSNumber* notesModified;

@property (strong, nonatomic) NSSet* getPhotosForBuildingInfo;
@property (strong, nonatomic) NSSet* getDocumentsForBuildingInfo;
@property (strong, nonatomic) NSSet* getBuildingScoresOnlyInfo;
@end
