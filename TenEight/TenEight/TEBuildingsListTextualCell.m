//
//  TETEBuildingsListTextualCell.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/19/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEBuildingsListTextualCell.h"

@implementation TEBuildingsListTextualCell

@synthesize buildingName;
@synthesize buildingAddress;
@synthesize editButton;
@synthesize deleteButton;
@synthesize selectButton;
@synthesize viewDetailsButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)buttonPressed:(UIButton *)sender
{
    switch (sender.tag) {
        case 1001:
            if ([self.delegate respondsToSelector:@selector(didSelectEdit:)]) {
                [self.delegate didSelectEdit:self.itemId];
            }
            break;
        case 1002:
            if ([self.delegate respondsToSelector:@selector(didSelectDelete:)]) {
                [self.delegate didSelectDelete:self.itemId];
            }
            break;
        case 1003:
            if ([self.delegate respondsToSelector:@selector(didSelectSelect:)]) {
                [self.delegate didSelectSelect:self.itemId];
            }
            break;
        case 1004:
            if ([self.delegate respondsToSelector:@selector(didSelectView:)]) {
                [self.delegate didSelectView:self.itemId];
            }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
