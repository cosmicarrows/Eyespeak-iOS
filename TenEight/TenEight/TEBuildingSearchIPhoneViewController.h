//
//  TEBuildingSearchIPhoneViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 10/4/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBuildingSearchListViewController.h"


@protocol TEBuildingSearchIPhoneViewControllerDelegate <NSObject>
@optional
- (void)didSelectBuildingFromList:(TEBuildingInfo *)searchBuilding;
@end

@interface TEBuildingSearchIPhoneViewController : TEBaseViewController <TEBuildingSearchListViewControllerDelegate, TEBuildingProxyDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UIView *buildingsSearchArea;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;

@property (nonatomic, strong) TEBuildingSearchListViewController *buildingsSearchListController;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic) NSInteger tourID;
@property (nonatomic, weak) id <TEBuildingSearchIPhoneViewControllerDelegate> delegate;

- (IBAction)donePressed:(id)sender;

@end


