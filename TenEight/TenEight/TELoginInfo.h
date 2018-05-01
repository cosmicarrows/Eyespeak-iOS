//
//  TELoginInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TELoginInfo : NSObject


@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* zip;



@end
