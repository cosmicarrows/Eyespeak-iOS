//
//  TESwitchUserController.h
//  TenEight
//
//  Created by Brad Wiederholt on 10/5/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEAppDelegate.h"
#import "TETourProxy.h"
#import "TEMembersProxy.h"
#import "TESyncController.h"


@protocol TESwitchUserControllerDelegate <NSObject>
- (void)didSwitchMember:(NSString *)member withSuccess:(BOOL)success;
@end

@interface TESwitchUserController : NSObject <RKObjectLoaderDelegate, TEMembersProxyDelegate, TETourProxyDelegate, TESyncControllerDelegate>

@property (strong, nonatomic) NSMutableArray *members;

@property (nonatomic, weak) id <TESwitchUserControllerDelegate> delegate;
@property (nonatomic, strong) TETourProxy *tourProxy;
@property (nonatomic, strong) TEMembersProxy *membersProxy;
@property (nonatomic) NSInteger currentTourID;
@property (nonatomic, strong) NSString *currentMember; // member we have switched to
@property (nonatomic, strong) NSString *desiredMember; // name of member we are trying to switch to
@property (nonatomic, strong) TESyncController *syncController;

- (NSArray *) getSwitchMembers;
- (void) setupControllerWithTour:(NSInteger)tourID;
- (void) switchToMember:(NSString *)memberID;

@end
