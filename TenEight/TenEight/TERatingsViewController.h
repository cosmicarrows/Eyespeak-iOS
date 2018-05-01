//
//  TERatingsViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/13/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TERatingsIPadCell.h"
#import "TERatingsIPhoneCell.h"

@protocol TERatingViewControllerDelegate <NSObject>
- (void) didUpdateAttribute:(int)attributeID withRating:(int)value;
@end

@interface TERatingsViewController : TEBaseViewController <UITableViewDelegate, UITableViewDataSource, TERatingsIPhoneCellDelegate, TERatingsIPadCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *ratingsTable;

@property (nonatomic, strong) NSArray *ratings;
@property (nonatomic, weak) id <TERatingViewControllerDelegate> delegate;


@end
