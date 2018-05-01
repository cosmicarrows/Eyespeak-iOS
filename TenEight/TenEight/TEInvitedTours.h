//
//  TEInvitedTours.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/24/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEInvitedTours : NSObject


@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* InvitedToursInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end

