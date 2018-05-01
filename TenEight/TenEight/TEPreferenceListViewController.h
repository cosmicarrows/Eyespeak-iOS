//
//  TEPreferenceListViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEPreferencesIPhoneCell.h"
#import "TEPreferencesIPadCell.h"


@protocol TEPreferenceListViewControllerDelegate <NSObject>
- (void) didUpdateAttribute:(int)attributeID withValue:(NSString *)value;
@end


@interface TEPreferenceListViewController : TEBaseViewController <UITableViewDataSource, UITableViewDelegate, TEPreferencesIPadCellDelegate, TEPreferencesIPhoneCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *preferencesTable;

@property (nonatomic, strong) NSArray *preferences;
@property (nonatomic, weak) id <TEPreferenceListViewControllerDelegate> delegate;

@end
