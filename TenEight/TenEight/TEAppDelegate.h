//
//  TEAppDelegate.h
//  TenEight
//
//  Created by Kennedy Kok on 8/8/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TESwitchUserController.h"

typedef enum TEUsers {TEUserPro, TEUserTenant} TEUserType;

@interface TEAppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) TELoginInfo *masterUserLoginInfo;
@property (nonatomic) TEUserType masterUserType;

@property (nonatomic) BOOL switchUserMode;
@property (nonatomic, strong) TESwitchUserController *switchUserController;

@property (nonatomic) BOOL toursListRefreshNeeded;
@property (nonatomic) BOOL allUIResetNeeded;


-(void) initObjectManager:(NSString*)dbName;
-(void) initObjectManagerForLogin;
@end

TEAppDelegate* theAppDelegate();