//
//  TERatingsIPhoneCell.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/13/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TERatingsIPhoneCell.h"

@implementation TERatingsIPhoneCell

@synthesize title;
@synthesize button1, button2, button3, button4, button5, button6;
@synthesize attributeID;
@synthesize value=_value;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setValue:(int)value
{
    _value = value;
    [self updateButtons];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateButtons
{
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = NO;
    switch (self.value) {
        case 1:
            button1.selected = YES;
            break;
        case 2:
            button2.selected = YES;
            break;
        case 3:
            button3.selected = YES;
            break;
        case 4:
            button4.selected = YES;
            break;
        case 5:
            button5.selected = YES;
            break;
        case 6:
            button6.selected = YES;
            break;
            
        default:
            break;
    }
}

- (void)buttonPressed:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        self.value = ((UIButton *)sender).tag;
        [self.delegate didUpdateAttribute:self.attributeID withValue:self.value];
        
    }
}

@end
