//
//  TEAddTourIPadBuildingsPanelViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/18/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBuildingListViewController.h"
#import "TEBuildingSearchListViewController.h"


@protocol TEAddTourIPadBuildingsPanelViewControllerDelegate <NSObject>
@optional
- (void)didSelectBuildingFromSearch:(TEBuildingInfo *)searchBuilding;
- (void)needEditBuilding:(TEBuildingInfoInTour *)building inTour:(NSInteger)tourID;
@end



@interface TEAddTourIPadBuildingsPanelViewController : TEBaseViewController <TEBuildingSearchListViewControllerDelegate, TEBuildingListViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *buildingsSearchArea;
@property (nonatomic, weak) IBOutlet UIView *buildingsArea;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) TEBuildingListViewController *buildingsController;
@property (nonatomic, strong) TEBuildingSearchListViewController *buildingsSearchListController;
@property (nonatomic, weak) id <TEAddTourIPadBuildingsPanelViewControllerDelegate> delegate;

@property (nonatomic) NSInteger tourID;

- (void)showBuildingsInTourDetails:(NSInteger)tourID;
- (void)showBuildingsInSearch:(NSArray *)searchBuildings;

@end
