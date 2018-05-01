//
//  TEDetailedErrorMessageInfo.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/19/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEDetailedErrorMessageInfo : NSObject

@property (strong, nonatomic) NSString* field;
@property (strong, nonatomic) NSString* msg;
@property (strong, nonatomic) NSString* type;

@end
