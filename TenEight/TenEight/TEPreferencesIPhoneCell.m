//
//  TEPreferencesIPhoneCell.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEPreferencesIPhoneCell.h"

@implementation TEPreferencesIPhoneCell

@synthesize title, secondary;
@synthesize button1, button2, button3;
@synthesize attributeID;
@synthesize value=_value;

- (void)setValue:(NSString *)value
{
    _value = value;
    [self updateButtons];
}

- (void)updateButtons
{
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    if ([self.value isEqualToString:@"L"]) {
        button1.selected = YES;
    }
    if ([self.value isEqualToString:@"M"]) {
        button2.selected = YES;
    }
    if ([self.value isEqualToString:@"H"]) {
        button3.selected = YES;
    }
}

- (void)buttonPressed:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        switch (((UIButton *)sender).tag) {
            case 1:
                self.value = @"L";
                break;
            case 2:
                self.value = @"M";
                break;
            case 3:
                self.value = @"H";
                break;
                
            default:
                break;
        }
        [self.delegate didUpdateAttribute:self.attributeID withValue:self.value];
    }
}



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
