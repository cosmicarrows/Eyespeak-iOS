//
//  TESyncViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 10/1/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TESyncController.h"

@protocol TESyncViewControllerDelegate <NSObject>
- (void)willDismissSyncView;
@optional
@end

@interface TESyncViewController : TEBaseViewController <TESyncControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextView* statusInfo;
@property (nonatomic, weak) IBOutlet UIButton* doneStopButton;
@property (nonatomic, weak) IBOutlet UILabel* status;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* activityIndicator;

@property (nonatomic, weak) id <TESyncViewControllerDelegate> delegate;

@property (nonatomic) BOOL processing;
@property (nonatomic, strong) TESyncController *syncController;

- (IBAction)doneStopPressed:(id)sender;
- (void) startDownloadForTour:(NSInteger)tourID;


@end
