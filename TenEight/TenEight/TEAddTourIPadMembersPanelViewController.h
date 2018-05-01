//
//  TEAddTourIPadMembersPanelViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/18/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEMembersListViewController.h"

@interface TEAddTourIPadMembersPanelViewController : TEBaseViewController

@property (nonatomic, weak) IBOutlet UIView *membersArea;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) TEMembersListViewController *membersController;

@property (nonatomic) NSInteger tourID;

- (void)showMemberDetails:(NSInteger)tourID;

@end
