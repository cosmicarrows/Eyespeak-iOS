//
//  TEAddEditTourViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/18/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import "TEAddTourIPadBuildingsPanelViewController.h"
#import "TEAddTourIPadMembersPanelViewController.h"
#import "TETourTypesPopoverViewController.h"

@protocol TEAddEditTourViewControllerDelegate <NSObject>
@optional
- (void)presentBuildingEditingViewController:(UIViewController *)theVC;
- (void)didAddOrModifyTour:(NSInteger)tourID;
@end


@interface TEAddEditTourViewController : TEBaseViewController <TETourProxyDelegate, TEBuildingProxyDelegate, UITextFieldDelegate, PopoverControllerDelegate, TETourTypePopoverDelegate, TEAddTourIPadBuildingsPanelViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *dataPanel;
@property (nonatomic, strong) IBOutlet UIView *membersPanel;
@property (nonatomic, strong) IBOutlet UIView *buildingsPanel;
@property (nonatomic, strong) IBOutlet UIView *tourHighlightPanel;
@property (nonatomic, strong) IBOutlet UIView *memberHighlightPanel;
@property (nonatomic, strong) IBOutlet UIView *buildingHighlightPanel;
@property (nonatomic, strong) IBOutlet UILabel *headingLabel;
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *memberAddressField;
@property (nonatomic, strong) IBOutlet UITextField *buildingNameField;
@property (nonatomic, strong) IBOutlet UITextField *addressField;
@property (nonatomic, strong) IBOutlet UITextField *rentableAreaField;
@property (nonatomic, strong) IBOutlet UITextField *ratePerSQFField;
@property (nonatomic, strong) IBOutlet UITextField *typeOfTourField;
@property (nonatomic, strong) IBOutlet UITextField *zipCodeField;
@property (nonatomic, strong) IBOutlet UIButton *addTourButton;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) IBOutlet UIButton *addBuildingButton;
@property (nonatomic, strong) IBOutlet UIButton *addMemberButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *typeAheadIndicator;

@property (nonatomic) BOOL loadInTourData;
@property (nonatomic) NSInteger currentTourID;
@property (nonatomic, strong) TETourInfo *currentTour;
@property (nonatomic, strong) WEPopoverController *tourTypePopoverController;
@property (nonatomic) NSInteger currentBuildingID;
@property (nonatomic, strong) TETourProxy *tourProxy;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;

@property (nonatomic) BOOL  selectedSearchBuilding;
@property (nonatomic, strong) NSString *selectedSearchBuildingAddress;
@property (nonatomic, strong) NSString *selectedSearchBuildingName;
@property (nonatomic, strong) NSString *selectedSearchBuildingZipCode;
@property (nonatomic) NSInteger selectedSearchBuildingID;


@property (nonatomic, weak) id <TEAddEditTourViewControllerDelegate> delegate;

@property (nonatomic, strong) TEAddTourIPadBuildingsPanelViewController *buildingPaneController;
@property (nonatomic, strong) TEAddTourIPadMembersPanelViewController *memberPaneController;

- (id)initWithTour:(TETourInfo *)tourInfo;

- (IBAction)addTourName:(id)sender;
- (IBAction)addBuilding:(id)sender;
- (IBAction)addMember:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)editingChanged:(id)sender;

@end
