//
//  TEBaseViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/3/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import "TESettingsPopoverViewController.h"
#import "TESwitchUserController.h"
#import "TEMembersPopoverViewController.h"


@interface TEBaseViewController : UIViewController <PopoverControllerDelegate, SettingsPopoverDelegate, TEMembersPopoverViewControllerDelegate, TESwitchUserControllerDelegate>

@property (nonatomic,strong) UIBarButtonItem *accountButton;
@property (nonatomic,strong) UIBarButtonItem *settingsButton;

@property (nonatomic, strong) WEPopoverController *accountsPopoverController;
@property (nonatomic, strong) WEPopoverController *settingsPopoverController;

@property (nonatomic, strong) NSMutableArray *iPhoneBaseBarItems;
@property (nonatomic, strong) NSMutableArray *iPhoneBaseBarItemsWithSwitchUser;
@property (nonatomic, strong) NSMutableArray *iPadBaseBarItems;

- (void)logout;
- (void)showPreferences;
- (void)provideMessage:(NSString *)message;
- (void)addBarButton:(UIBarButtonItem *)item;
- (void)removeBarButton;
- (void)changeToiPadBaseBarItems;
- (void)changeToiPhoneBaseBarItems;
- (void)changeToiPhoneBaseBarItemsWithSwitchUser;


@end
