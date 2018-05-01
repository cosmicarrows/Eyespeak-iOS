//
//  TEUpdateBuilding.h
//  TenEight
//
//  Created by Brad Wiederholt on 11/18/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEUpdateBuilding : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
