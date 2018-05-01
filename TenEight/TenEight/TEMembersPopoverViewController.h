//
//  TEMembersPopoverViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 10/5/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TETourMember.h"

@protocol TEMembersPopoverViewControllerDelegate <NSObject>
- (void)memberSelected:(NSString *)memberName;
@end

@interface TEMembersPopoverViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *membersTable;


@property (nonatomic,weak) id<TEMembersPopoverViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *members;

@end
