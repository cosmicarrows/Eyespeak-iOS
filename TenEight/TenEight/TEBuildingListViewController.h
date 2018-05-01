//
//  TEBuildingListViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 8/31/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "TETourInfo.h"
#import "TESyncViewController.h"
#import "TEBuildingsListTextualCell.h"

@protocol TEBuildingListViewControllerDelegate <NSObject>
- (void)needEditBuilding:(TEBuildingInfoInTour *)building inTour:(NSInteger)tourID;
@end


@interface TEBuildingListViewController : TEBaseViewController <TEBuildingProxyDelegate, TETourProxyDelegate, TEPhotoProxyDelegate, UITableViewDelegate, UITableViewDataSource, TEBuildingsListTextualCellDelegate>

enum BuildingListTypes {
    BuildingListIPadVisual,
    BuildingListIPhoneDrillDown,
    BuildingListWithOptions
};


@property (nonatomic, weak) IBOutlet UITableView *buildingTableView;
@property (nonatomic, weak) IBOutlet UILabel *tourName;
@property (nonatomic, weak) IBOutlet UIButton *tourSyncButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL aiShouldBeSpinning;

@property (nonatomic, strong) NSArray *buildings;
@property (nonatomic, strong) TEBuildingInfoInTour *selectedBuilding;
@property (nonatomic) NSInteger currentTourID;
@property (nonatomic, weak) TETourInfo *tour;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic, strong) TETourProxy *tourProxy;
@property (nonatomic, strong) TEPhotoProxy *photoProxy;
@property (nonatomic, strong) UIViewController *parentStoryboard;
@property (nonatomic, strong) TESyncViewController *syncViewController;
@property (nonatomic, weak) id <TEBuildingListViewControllerDelegate> delegate;

@property (nonatomic) NSUInteger buildingListType;

- (void)loadBuildingsInTour:(NSInteger)tourID;

- (IBAction)tourSyncPressed:(id)sender;

@end