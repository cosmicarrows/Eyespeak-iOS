//
//  TEPostPhoto.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEPostPhotoInfo.h"

@interface TEPostPhoto : NSObject

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TEPostPhotoInfo *PostPhotoInfo;
@property (strong, nonatomic) NSArray* detailedErrorMessage;
@end
