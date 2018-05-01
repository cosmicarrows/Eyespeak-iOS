//
//  TEMemberMaintenanceIPhoneViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/20/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEMembersListViewController.h"

@interface TEMemberMaintenanceIPhoneViewController : TEBaseViewController <TETourProxyDelegate>

@property (nonatomic, strong) IBOutlet UITextField *memberAddressField;
@property (nonatomic, strong) IBOutlet UIButton *addMemberButton;
@property (nonatomic, strong) IBOutlet UIView *membersArea;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) TEMembersListViewController *membersController;
@property (nonatomic) NSInteger tourID;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) TETourProxy *tourProxy;


- (IBAction)addMember:(id)sender;
- (void)toggleEditMode:(NSNotification *)notification;

@end
