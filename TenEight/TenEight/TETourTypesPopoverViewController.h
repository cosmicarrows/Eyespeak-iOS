//
//  TETourTypesPopoverViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/18/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TETourTypePopoverDelegate
- (void)selectedTourType:(NSString *)type;
@end


@interface TETourTypesPopoverViewController : UIViewController

@property (nonatomic,weak) id<TETourTypePopoverDelegate> delegate;

- (IBAction)buttonPressed:(id)sender;

@end
