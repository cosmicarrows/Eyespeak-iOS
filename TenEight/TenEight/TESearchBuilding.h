//
//  TESearchBuilding.h
//  TenEight
//
//  Created by Kennedy Kok on 8/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TESearchBuilding : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* SearchBuildingInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
