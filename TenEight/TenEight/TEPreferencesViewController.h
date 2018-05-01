//
//  TEPreferencesViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/4/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEPreferenceListViewController.h"

@interface TEPreferencesViewController : TEBaseViewController <TEPreferenceListViewControllerDelegate, TEPreferencesProxyDelegate>

typedef enum {
    TEPreferenceTypeRetail = 0,
    TEPreferenceTypeOffice = 1,
    TEPreferenceTypeIndustrial = 2
} TEPreferenceType;


@property (nonatomic) TEPreferenceType preferenceType;



@property (strong, nonatomic) IBOutlet UIButton* doneButton;
@property (nonatomic, weak) IBOutlet UISegmentedControl *typeSegmentedControl;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UIView *preferencesView;
@property (nonatomic) BOOL aiShouldBeSpinning;


@property (nonatomic, strong) TEPreferenceListViewController *preferenceListViewController;
@property (nonatomic, strong) TEPreferencesProxy *preferencesProxy;
@property (nonatomic, strong) NSArray *preferences;
@property (nonatomic) BOOL updatingCache;

- (IBAction)done:(id)sender;
- (void)loadPreferences;

- (IBAction)changePreferenceType:(id)sender;


@end
