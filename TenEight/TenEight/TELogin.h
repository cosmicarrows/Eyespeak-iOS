//
//  TELogin.h
//  TenEight
//
//  Created by Kennedy Kok on 8/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TELogin : TEBase <RKObjectLoaderDelegate>


-(void) login:(NSString*) email password:(NSString*) pw typeOfUser:(int) type;

@property (strong, nonatomic) TEStatus* responseStatus;
@property (strong, nonatomic) TELoginInfo* LoginInfo;


@end
