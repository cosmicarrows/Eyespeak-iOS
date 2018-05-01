//
//  TESortViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TESortViewControllerDelegate <NSObject>

- (void) sortPressed:(int)value;
- (void) sortDone;

@end

@interface TESortViewController : TEBaseViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic) int sortOrder;

@property (nonatomic, weak) IBOutlet UITableView *sortOptionsTable;

@property (nonatomic, weak) id <TESortViewControllerDelegate> delegate;

@end
