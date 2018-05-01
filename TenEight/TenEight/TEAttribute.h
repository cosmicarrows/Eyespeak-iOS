//
//  Attribute.h
//  TenEight
//
//  Created by Kennedy Kok on 8/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEAttribute : NSManagedObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* desc;
@property (strong, nonatomic) NSString* value;
@property (strong, nonatomic) NSString* attributeID;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) NSNumber* modified;

@end
