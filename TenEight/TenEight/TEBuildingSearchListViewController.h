//
//  TEBuildingSearchListViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 10/3/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "TEBuildingsListTextualCell.h"

@protocol TEBuildingSearchListViewControllerDelegate <NSObject>
@optional
- (void)didSelectView:(TEBuildingInfo *)searchBuilding;
- (void)didSelectBuildingFromList:(TEBuildingInfo *)searchBuilding;
@end

@interface TEBuildingSearchListViewController : TEBaseViewController <UITableViewDelegate, UITableViewDataSource,TEBuildingsListTextualCellDelegate>

enum SearchCellType {
    CellTypeAdd,
    CellTypeView
};

@property (nonatomic, weak) IBOutlet UITableView *buildingTableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) NSInteger cellType;
@property (nonatomic, weak) id <TEBuildingSearchListViewControllerDelegate> delegate;

@property (nonatomic, strong) NSArray *searchBuildings;

- (void)showSearchBuildings:(NSArray *)searchBuildings;

@end
