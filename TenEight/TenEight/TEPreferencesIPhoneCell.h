//
//  TEPreferencesIPhoneCell.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TEPreferencesIPhoneCellDelegate <NSObject>
- (void)didUpdateAttribute:(int)attributeID withValue:(NSString *)value;
@end


@interface TEPreferencesIPhoneCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *secondary;
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIButton *button3;
@property (nonatomic) int attributeID;
@property (nonatomic) NSString *value;
@property (nonatomic, weak) id <TEPreferencesIPhoneCellDelegate> delegate;

- (IBAction)buttonPressed:(id)sender;
@end
