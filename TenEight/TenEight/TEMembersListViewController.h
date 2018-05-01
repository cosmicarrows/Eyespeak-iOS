//
//  TEMembersListViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/14/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEMembersListIPadCell.h"

@interface TEMembersListViewController : TEBaseViewController <UITableViewDataSource, UITableViewDelegate, TEMembersProxyDelegate, TEMembersListIPadCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *memberTableView;
@property (nonatomic) NSInteger currentTourID;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) TEMembersProxy *membersProxy;
@property (nonatomic, strong) NSArray *members;

- (void)loadMembersInTour:(NSInteger)tourID;
- (BOOL)toggleEditMode;

@end


