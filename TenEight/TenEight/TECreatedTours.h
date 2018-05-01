//
//  TECreatedTours.h
//  TenEight
//
//  Created by Kennedy Kok on 8/20/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TECreatedTours : NSObject


@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) NSArray* CreatedToursInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;

@end
