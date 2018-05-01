//
//  TEMembersListIPadCell.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEMembersListIPadCell.h"

@implementation TEMembersListIPadCell

@synthesize deleteButton;
@synthesize memberID;
@synthesize delegate;
@synthesize dbid;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)delete:(id)sender
{
    [self.delegate deletePressed:self.dbid];
}


@end
