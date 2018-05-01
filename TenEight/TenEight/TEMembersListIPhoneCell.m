//
//  TEMembersListIPhoneCell.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/20/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEMembersListIPhoneCell.h"

@implementation TEMembersListIPhoneCell

@synthesize memberID;

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

@end
