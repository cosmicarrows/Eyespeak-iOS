//
//  TEDocumentInfo.h
//  TenEight
//
//  Created by Kennedy Kok on 8/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEDocumentInfo : NSManagedObject

@property (strong, nonatomic) NSString* document;
@property (strong, nonatomic) NSNumber *documentID;
@property (strong, nonatomic) TEDetailsForBuilding* building;

@end
