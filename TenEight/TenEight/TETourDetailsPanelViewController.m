//
//  TETourDetailsPanelViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/7/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TETourDetailsPanelViewController.h"
#import "TEAddEditBuildingViewController.h"

@interface TETourDetailsPanelViewController ()

@end

@implementation TETourDetailsPanelViewController

@synthesize tourName;
@synthesize buildingsArea;
@synthesize buildingsController;
@synthesize membersArea;
@synthesize membersController;
@synthesize selectedTour;
@synthesize buildingsCount;
@synthesize membersCount;
@synthesize activityIndicator;
@synthesize editButton;
@synthesize downloadButton;
@synthesize parentStoryboard;
@synthesize syncViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImage *buttonImage = [[UIImage imageNamed:@"button_red"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"button_red_highlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageDisabled = [[UIImage imageNamed:@"button_red_disabled.png"]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [editButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [editButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [editButton setBackgroundImage:buttonImageDisabled forState:UIControlStateDisabled];
    [downloadButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [downloadButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [downloadButton setBackgroundImage:buttonImageDisabled forState:UIControlStateDisabled];
    

    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(130, 232), CGAffineTransformMakeRotation(-M_PI_2));
    buildingsArea.transform = transform;
    
    self.buildingsController = [[TEBuildingListViewController alloc] init];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 256, 722) style:UITableViewStylePlain];
    table.dataSource = self.buildingsController;
    table.delegate = buildingsController;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [table setShowsVerticalScrollIndicator:NO];
    self.buildingsController.buildingTableView = table;
    self.buildingsController.buildingListType = BuildingListIPadVisual;
    self.buildingsController.parentStoryboard = self.parentStoryboard;
    [[self.buildingsArea subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buildingsArea addSubview:table];
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    [ai setFrame:CGRectMake(100, 320, 37, 37)];
    [ai setColor:[UIColor colorWithRed:101/255.0 green:2/255.0 blue:0/255.0 alpha:1]];
    self.buildingsController.activityIndicator = ai;
    [self.buildingsArea addSubview:ai];

    self.membersController = [[TEMembersListViewController alloc] init];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 754, 216) style:UITableViewStylePlain];
    table.dataSource = self.membersController;
    table.delegate = self.membersController;
    self.membersController.memberTableView = table;
    [[self.membersArea subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.membersArea addSubview:table];
    UIActivityIndicatorView *aim = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    [aim setFrame:CGRectMake(320, 90, 37, 37)];
    [aim setColor:[UIColor colorWithRed:101/255.0 green:2/255.0 blue:0/255.0 alpha:1]];
    self.membersController.activityIndicator = aim;
    [self.membersArea addSubview:aim];

    
}

- (void)showTourDetails:(TETourInfo *)tourInfo
{
    self.selectedTour = tourInfo;
    [self updateUI];
}

- (void)updateUI
{
    self.tourName.text = self.selectedTour.name;
    self.buildingsCount.text= [[self.selectedTour.buildingCount stringValue] stringByAppendingString:@" Building"];
    if ([self.selectedTour.buildingCount intValue] != 1)
        self.buildingsCount.text = [self.buildingsCount.text stringByAppendingString:@"s"];
    self.membersCount.text= [[self.selectedTour.memberCount stringValue] stringByAppendingString:@" Member"];
    if ([self.selectedTour.memberCount intValue] != 1)
        self.membersCount.text = [self.membersCount.text stringByAppendingString:@"s"];
    
    
    [self.buildingsController setTour:self.selectedTour];
    [self.buildingsController loadBuildingsInTour:[self.selectedTour.tourID intValue]];
    
    [self.membersController loadMembersInTour:[self.selectedTour.tourID intValue]];
    
    if (!theAppDelegate().switchUserMode && (theAppDelegate().masterUserType==TEUserPro)) {
        self.editButton.hidden = NO;
    } else {
        self.editButton.hidden = YES;
    }
    
}

- (void)editTour:(id)sender
{
    DDLogVerbose (@"editing tour");
    TEAddEditTourViewController *addVC = [[TEAddEditTourViewController alloc] initWithTour:self.selectedTour];
    addVC.delegate = self;
    [self presentViewController:addVC animated:YES completion:nil];
}

- (void)didAddOrModifyTour:(NSInteger)tourID
{
//    [self updateUI];
    [self.delegate didModifyCurrentTourDetails];
}


- (void)presentBuildingEditingViewController:(UIViewController *)theVC
{
    [self presentViewController:theVC animated:YES completion:nil];
}


- (void)downloadTour:(id)sender
{
    self.syncViewController = [[TESyncViewController alloc] init];
    [self.syncViewController setDelegate:self];
    syncViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:self.syncViewController animated:YES completion:nil];
    [self.syncViewController startDownloadForTour:[self.selectedTour.tourID intValue]];
}

- (void)willDismissSyncView
{
    [self.delegate didDismissSyncView];
}


- (void)viewWillAppear:(BOOL)animated
{
    if (!theAppDelegate().switchUserMode && (theAppDelegate().masterUserType==TEUserPro)) {
        self.editButton.hidden = NO;
    } else {
        self.editButton.hidden = YES;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.buildingsController = nil;
    self.membersController = nil;
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSString *errordesc = [((NSError *)error) localizedDescription];
    if ([error code]==4) {
        errordesc  = @"Network error.  The connection was blocked (you may need to first log in to the wireless network) or the server has failed to respond.";
    }

    [self provideMessage:errordesc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
    else
    {
        return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
                (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end
