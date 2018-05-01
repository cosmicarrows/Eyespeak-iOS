//
//  TEAddEditBuildingViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 10/4/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEAddEditBuildingViewController : TEBaseViewController <TEBuildingProxyDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIView *dataPanel;
@property (nonatomic, strong) IBOutlet UILabel *headingLabel;
@property (nonatomic, strong) IBOutlet UITextField *buildingNameField;
@property (nonatomic, strong) IBOutlet UITextField *addressField;
@property (nonatomic, strong) IBOutlet UITextField *rentableAreaField;
@property (nonatomic, strong) IBOutlet UITextField *ratePerSQFField;
@property (nonatomic, strong) IBOutlet UITextField *zipCodeField;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) IBOutlet UIButton *addEditBuildingButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NSInteger currentBuildingID;
@property (nonatomic, strong) TEBuildingInfoInTour *currentBuilding;
@property (nonatomic, strong) NSNumber *currentRentableArea;
@property (nonatomic, strong) NSNumber *currentRatePerSQF;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic) NSInteger currentTourID;
@property (nonatomic) BOOL editingABuilding;
@property (nonatomic, strong) TEBuildingRentalInfo *rentalInfo;

- (id) initWithBuilding:(TEBuildingInfoInTour *)buildingInfo tourID:(NSInteger)tourID;
- (IBAction)addEditBuilding:(id)sender;
- (IBAction)done:(id)sender;

@end
