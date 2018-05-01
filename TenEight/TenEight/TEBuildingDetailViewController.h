//
//  TEBuildingDetailViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/3/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "TENoteViewController.h"
#import "TEGetPhotoViewController.h"
#import "TERatingsViewController.h"


@interface TEBuildingDetailViewController : TEBaseViewController <TEBuildingProxyDelegate, TEPhotoProxyDelegate, TENoteViewControllerDelegate, TEGetPhotoViewControllerDelegate, TERatingViewControllerDelegate>


@property (nonatomic, weak) IBOutlet UILabel *lblBuildingName;
@property (nonatomic, weak) IBOutlet UILabel *lblBldOrTourName;
@property (nonatomic, weak) IBOutlet UILabel *lblOverallScore;
@property (nonatomic, weak) IBOutlet UILabel *lblMyScore;
@property (nonatomic, weak) IBOutlet UILabel *lblGroupScore;
@property (nonatomic, weak) IBOutlet UILabel *lblGlobalScore;
@property (nonatomic, weak) IBOutlet UILabel *lblAddress;
@property (nonatomic, weak) IBOutlet UILabel *lblRSF;
@property (nonatomic, weak) IBOutlet UILabel *lblRpSF;
@property (nonatomic, weak) IBOutlet UILabel *lblMR;
@property (nonatomic, weak) IBOutlet UILabel *lblNumFiles;
@property (nonatomic, weak) IBOutlet UILabel *lblNumPhotos;
@property (nonatomic, weak) IBOutlet UILabel *lblSampleNote;
@property (nonatomic, weak) IBOutlet UIButton *viewNotesButton;
@property (nonatomic, weak) IBOutlet UIButton *editNotesButton;
@property (nonatomic, weak) IBOutlet UIButton *viewPhotosButton;
@property (nonatomic, weak) IBOutlet UIButton *addPhotoButton;
@property (nonatomic, weak) IBOutlet UIButton *viewDocumentsButton;
@property (nonatomic, weak) IBOutlet UIButton *ratingsDoneButton;
@property (nonatomic, weak) IBOutlet UIView *ratingsView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *viewSwitch;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL aiShouldBeSpinning;

@property (nonatomic, strong) TEBuildingInfoInTour *building;
@property (nonatomic, strong) TETourInfo *tour;
@property (nonatomic, strong) TEDetailsForBuilding *detailsForBuildingInfo;
@property (nonatomic, strong) TERatingsViewController *ratingsViewController;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic, strong) TEPhotoProxy *photoProxy;
@property (nonatomic, strong) TEBuildingRentalInfo *rentalInfo;
@property (nonatomic) int viewState;
@property (nonatomic) NSInteger bID;
@property (nonatomic) NSInteger tID;
@property (nonatomic) BOOL loadBuildingDetailsAfterRated;
@property (nonatomic) NSInteger loadBuildingDetailsAfterRatedBID;
@property (nonatomic) NSInteger loadBuildingDetailsAfterRatedTID;
@property (nonatomic, strong) NSArray *localScores;
@property (nonatomic, strong) NSString *localNotes;
@property (nonatomic) BOOL updateUsingLocalInfo;

- (void)loadBuildingDetails:(NSNumber *)buildingID inTour:(NSNumber *)tourID;
- (void)presentNewBuilding:(NSNumber *)buildingID inTour:(NSNumber *)tourID;

- (IBAction)changeView:(id)sender;
- (IBAction)ratingsDone:(id)sender;

@end
