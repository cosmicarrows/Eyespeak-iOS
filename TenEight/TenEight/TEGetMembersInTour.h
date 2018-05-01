//
//  TEGetMembersInTour.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/14/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEGetMembersInTour : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* GetMembersInTourInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
