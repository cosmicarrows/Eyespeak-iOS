//
//  TETourSplitViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 8/29/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "TETourDetailsPanelViewController.h"
#import "TESortViewController.h"
#import "TESyncController.h"
#import "TEAddEditTourViewController.h"
#import "TEAddEditBuildingViewController.h"


@interface TETourViewController : TEBaseViewController  <TETourProxyDelegate, UITableViewDelegate, TESortViewControllerDelegate, TETourDetailsPanelViewControllerDelegate, TESyncControllerDelegate>
{
}
@property (nonatomic, weak) IBOutlet UIButton *addTourButton;
@property (nonatomic, weak) IBOutlet UIButton *addTourButton2;
@property (nonatomic, weak) IBOutlet UIButton *sortToursButton;
@property (nonatomic, weak) IBOutlet UITableView *tourTableView;
@property (nonatomic, weak) IBOutlet UILabel *tourCount;
@property (nonatomic, weak) IBOutlet UIView *tourDetailsPanel;
@property (nonatomic, weak) IBOutlet UIView *defaultPanel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) TETourDetailsPanelViewController *tourDetailsController;
@property (nonatomic, strong) TETourProxy *tourProxy;
@property (nonatomic, strong) TESyncController *syncController;
@property (nonatomic, strong) TEAddEditBuildingViewController *editBuildingVC;
@property (nonatomic) BOOL editBuildingNeeded;

@property (nonatomic) NSInteger selectedTourIndex;
@property (nonatomic, strong) NSMutableArray *tours;
@property (nonatomic) int sortOrder;

- (IBAction)addTour:(id)sender;

@end
