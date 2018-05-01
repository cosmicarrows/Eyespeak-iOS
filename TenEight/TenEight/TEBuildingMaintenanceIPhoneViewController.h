//
//  TEBuildingMaintenanceIPhoneViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/20/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBuildingSearchIPhoneViewController.h"

@interface TEBuildingMaintenanceIPhoneViewController : TEBaseViewController <TETourProxyDelegate, TEBuildingProxyDelegate, UITextFieldDelegate, TEBuildingSearchIPhoneViewControllerDelegate >

@property (nonatomic, strong) IBOutlet UITextField *buildingNameField;
@property (nonatomic, strong) IBOutlet UITextField *addressField;
@property (nonatomic, strong) IBOutlet UITextField *rentableAreaField;
@property (nonatomic, strong) IBOutlet UITextField *ratePerSQFField;
@property (nonatomic, strong) IBOutlet UITextField *zipCodeField;
@property (nonatomic, strong) IBOutlet UIButton *addBuildingButton;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic) CGPoint offset;
@property (nonatomic) NSInteger tourID;
@property (nonatomic, strong) TETourProxy *tourProxy;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic) NSInteger currentBuildingID;

@property (nonatomic) BOOL  selectedSearchBuilding;
@property (nonatomic, strong) NSString *selectedSearchBuildingAddress;
@property (nonatomic, strong) NSString *selectedSearchBuildingName;
@property (nonatomic, strong) NSString *selectedSearchBuildingZipCode;
@property (nonatomic) NSInteger selectedSearchBuildingID;


- (IBAction)addBuilding:(id)sender;

@end
