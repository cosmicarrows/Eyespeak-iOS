//
//  TETourDetailsPanelViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/7/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBuildingListViewController.h"
#import "TEMembersListViewController.h"
#import "TESyncViewController.h"
#import "TEAddEditTourViewController.h"


@protocol TETourDetailsPanelViewControllerDelegate <NSObject>
- (void)didDismissSyncView;
- (void)didModifyCurrentTourDetails;
@optional
@end

@interface TETourDetailsPanelViewController : TEBaseViewController <TESyncViewControllerDelegate, TEAddEditTourViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *buildingsArea;
@property (nonatomic, weak) IBOutlet UIView *membersArea;
@property (nonatomic, weak) IBOutlet UILabel *tourName;
@property (nonatomic, weak) IBOutlet UILabel *buildingsCount;
@property (nonatomic, weak) IBOutlet UILabel *membersCount;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, weak) IBOutlet UIButton *downloadButton;


@property (nonatomic, strong) TEBuildingListViewController *buildingsController;
@property (nonatomic, strong) TEMembersListViewController *membersController;
@property (nonatomic, strong) UIViewController *parentStoryboard;

@property (nonatomic, strong) TETourInfo *selectedTour;
@property (nonatomic, strong) TESyncViewController *syncViewController;

@property (nonatomic, weak) id <TETourDetailsPanelViewControllerDelegate> delegate;

- (void) showTourDetails: (TETourInfo *)tourInfo;
- (IBAction)downloadTour:(id)sender;
- (IBAction)editTour:(id)sender;

@end
