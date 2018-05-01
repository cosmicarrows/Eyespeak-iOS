//
//  TEMembersListIPadCell.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TEMembersListIPadCellDelegate <NSObject>
- (void)deletePressed:(NSString *)dbid;
@end

@interface TEMembersListIPadCell : UITableViewCell

@property (nonatomic, strong) NSString *dbid;
@property (nonatomic, strong) IBOutlet UILabel *memberID;
@property (nonatomic, strong) IBOutlet UIButton *deleteButton;

@property (nonatomic, weak) id <TEMembersListIPadCellDelegate> delegate;

- (IBAction)delete:(id)sender;

@end

