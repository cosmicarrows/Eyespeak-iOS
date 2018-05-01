//
//  TETourMember.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/14/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TETourMember : NSManagedObject

@property (strong, nonatomic) NSNumber* tourId;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* email;

@end
