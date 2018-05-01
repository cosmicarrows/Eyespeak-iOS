//
//  TEBuildingViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 8/29/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "TEAddEditBuildingViewController.h"
#import "TEBuildingSearchListViewController.h"


@interface TEBuildingViewController : TEBaseViewController  <TEBuildingProxyDelegate, UITableViewDelegate, UISearchBarDelegate, TEBuildingSearchListViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *addBuildingButton;
@property (nonatomic, weak) IBOutlet UIView *searchListView;
@property (nonatomic, weak) IBOutlet UILabel *buildingCount;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL aiShouldBeSpinning;

@property (nonatomic) NSInteger selectedBuildingIndex;
@property (nonatomic, weak) NSArray *buildings;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic, strong) TEBuildingInfo *selectedBuilding;
@property (nonatomic, strong) TEBuildingSearchListViewController *searchListVC;

- (IBAction)addBuilding:(id)sender;

@end
