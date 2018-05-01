//
//  TESettingsPopoverViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 8/30/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsPopoverDelegate
- (void)logout;
- (void)showPreferences;
@end


@interface TESettingsPopoverViewController : UIViewController

@property (nonatomic,weak) id<SettingsPopoverDelegate> delegate;

- (IBAction)logout:(id)sender;
- (IBAction)showPreferences:(id)sender;

@end
