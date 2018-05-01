//
//  TERatingsIPhoneCell.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/13/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TERatingsIPhoneCellDelegate <NSObject>
- (void)didUpdateAttribute:(int)attributeID withValue:(int)value;
@end


@interface TERatingsIPhoneCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIButton *button3;
@property (nonatomic, weak) IBOutlet UIButton *button4;
@property (nonatomic, weak) IBOutlet UIButton *button5;
@property (nonatomic, weak) IBOutlet UIButton *button6;
@property (nonatomic) int attributeID;
@property (nonatomic) int value;
@property (nonatomic, weak) id <TERatingsIPhoneCellDelegate> delegate;

- (IBAction)buttonPressed:(id)sender;

@end
