//
//  TEBuildingIPadDetailViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "TENotesViewerViewController.h"
#import "TEPhotoAcquireViewController.h"
#import "TERatingsViewController.h"
#import "TEPhotoAreaViewController.h"
#import "TEPhotoViewerViewController.h"
#import "TEDocumentAreaViewController.h"

@interface TEBuildingIPadDetailViewController : TEBaseViewController <TEBuildingProxyDelegate, TETourProxyDelegate, TEPhotoProxyDelegate,TEPhotoAreaViewControllerDelegate,TERatingViewControllerDelegate,TEPhotoAcquireViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *lblBuildingName;
@property (nonatomic, weak) IBOutlet UILabel *lblTourName;
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
@property (nonatomic, weak) IBOutlet UIButton *viewRatingsButton;
@property (nonatomic, weak) IBOutlet UIButton *saveNotesButton;
@property (nonatomic, weak) IBOutlet UIButton *gobackButton;
@property (nonatomic, weak) IBOutlet UIButton *switchUserButton;
@property (nonatomic, weak) IBOutlet UIButton *ratingsDoneButton;
@property (nonatomic, weak) IBOutlet UIView *ratingsView;
@property (nonatomic, weak) IBOutlet UIView *documentsView;
@property (nonatomic, weak) IBOutlet UIView *documentViewerView;
@property (nonatomic, weak) IBOutlet UIView *photosView;
@property (nonatomic, weak) IBOutlet UIView *photoViewerView;
@property (nonatomic, weak) IBOutlet UIView *addPhotosView;
@property (nonatomic, weak) IBOutlet UIView *notesView;
@property (nonatomic, weak) IBOutlet UIView *loadingView;
@property (nonatomic, weak) IBOutlet UIView *noDetailsView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) TERatingsViewController *ratingsViewController;
@property (nonatomic, strong) TEPhotoAreaViewController *photoAreaViewController;
@property (nonatomic, strong) TEPhotoViewerViewController *photoViewerViewController;
@property (nonatomic, strong) TENotesViewerViewController *notesViewViewController;
@property (nonatomic, strong) TEDocumentAreaViewController *documentAreaViewController;
@property (nonatomic, strong) TEPhotoAcquireViewController *photoAcquireViewController;

@property (nonatomic, strong) TEBuildingInfoInTour *building;
@property (nonatomic, strong) TETourInfo *tour;
@property (nonatomic, strong) TEDetailsForBuilding *detailsForBuildingInfo;
@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic, strong) TEPhotoProxy *photoProxy;
@property (nonatomic, strong) TEBuildingRentalInfo *rentalInfo;
@property (nonatomic) NSInteger bID;
@property (nonatomic) NSInteger tID;
@property (nonatomic) BOOL updatingRatings;
@property (nonatomic) BOOL loadBuildingDetailsAfterRated;
@property (nonatomic) NSInteger loadBuildingDetailsAfterRatedBID;
@property (nonatomic) NSInteger loadBuildingDetailsAfterRatedTID;
@property (nonatomic, strong) NSArray *localScores;
@property (nonatomic, strong) NSString *localNotes;
@property (nonatomic) BOOL updateUsingLocalInfo;

@property (nonatomic) int viewState;

- (void)loadBuildingDetails:(NSNumber *)buildingID inTour:(NSNumber *)tourID;
- (void)presentNewBuilding:(NSNumber *)buildingID inTour:(NSNumber *)tourID;

- (IBAction)viewPhotos:(id)sender;
- (IBAction)viewDocuments:(id)sender;
- (IBAction)viewNotes:(id)sender;
- (IBAction)addPhotos:(id)sender;
- (IBAction)viewRatings:(id)sender;
- (IBAction)saveNotesPressed:(id)sender;
- (IBAction)gobackPressed:(id)sender;
- (IBAction)switchUserPressed:(id)sender;
- (IBAction)ratingsDone:(id)sender;

@end
