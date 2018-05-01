//
//  TEBuildingViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 8/29/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEBuildingViewController.h"
#import "DDLog.h"

@interface TEBuildingViewController ()

@end

@implementation TEBuildingViewController

@synthesize addBuildingButton;
@synthesize buildings;
@synthesize buildingCount;
@synthesize searchBar;
@synthesize activityIndicator;
@synthesize selectedBuildingIndex;
@synthesize searchListView;
@synthesize searchListVC;
@synthesize selectedBuilding;


#pragma mark TEBuildingDelegate methods

- (void)buildingsLoaded:(NSNotification *)note
{
    
    [self stopIndicator];
    
    NSDictionary *params = note.userInfo;
    BOOL success = [(NSNumber *)[params objectForKey:@"success"] boolValue];
    
    if (success) {
        self.buildings = self.buildingProxy.searchBuildings;
        [self.searchListVC showSearchBuildings:self.buildings];

        [self updateUIPieces];
    } else {
        NSString *message = (NSString *)[params objectForKey:@"message"];
        [self provideMessage:message];
    }
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(buildingsLoaded:)
                   name:@"TEBuildingProxy_SearchBuildingsUpdated"
                 object:nil];
        self.buildingProxy = [[TEBuildingProxy alloc] init];
        [self.buildingProxy setDelegate:self];

    }
    return self;
}


-(void)updateUIPieces {
    self.buildingCount.text = [NSString stringWithFormat:@"%d Buildings", [self.buildings count]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.searchBar resignFirstResponder];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)sBar {
    [searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.aiShouldBeSpinning) {
        [self startIndicator];
    }

    if (!theAppDelegate().switchUserMode && (theAppDelegate().masterUserType==TEUserPro)) {
        self.addBuildingButton.hidden = NO;
    } else {
        self.addBuildingButton.hidden = YES;
    }
 
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
    
    [addBuildingButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [addBuildingButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [addBuildingButton setBackgroundImage:buttonImageDisabled forState:UIControlStateDisabled];
    
    self.searchListVC = [[TEBuildingSearchListViewController alloc] init];
    self.searchListVC.cellType = CellTypeView;
    self.searchListVC.delegate = self;
    [[self.searchListView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.searchListVC.view setFrame:CGRectMake(0, 0, self.searchListView.frame.size.width, self.searchListView.frame.size.height)];
    [self.searchListView addSubview:self.searchListVC.view];


    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(buildingsLoaded:)
               name:@"TEBuildingProxy_BuildingInTourUpdated"
             object:nil];

    [self updateUIPieces];
}

- (void)didSelectView:(TEBuildingInfo *)searchBuilding
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.selectedBuilding = searchBuilding;
        
        // On the iPad we need to go to completely different tab
        // fake a buildingInTour so we can go to that screen on iPad
        TEBuildingInfoInTour *bit = (TEBuildingInfoInTour *)[NSEntityDescription insertNewObjectForEntityForName:@"TEBuildingInfoInTour" inManagedObjectContext:[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread];
        bit.name = self.selectedBuilding.name;
        bit.address = self.selectedBuilding.address;
        bit.myScore = self.selectedBuilding.myScore;
        bit.groupScore = self.selectedBuilding.groupScore;
        bit.globalScore = self.selectedBuilding.globalScore;
        bit.buildingID = self.selectedBuilding.buildingID;
        bit.key = nil;
        bit.tourID = nil;
        bit.imageID = nil;
        bit.thumbImage = nil;
        bit.largeImage = nil;
        
        NSError *error;
        [[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread save:&error];

        NSDictionary *extraInfo = [NSDictionary dictionaryWithObjectsAndKeys:bit, @"selectedBuilding", nil, @"tour", nil];
        NSNotification *note = [NSNotification notificationWithName:@"ShowBuildingDetails" object:self userInfo:extraInfo];
        [[NSNotificationCenter defaultCenter] postNotification:note];
        
    }

}

- (void)addBuilding:(id)sender
{
    DDLogVerbose (@"adding buildings");
    TEAddEditBuildingViewController *addVC = [[TEAddEditBuildingViewController alloc] init];
    [self presentViewController:addVC animated:YES completion:nil];
}


#pragma mark SearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchBar.text.length >= 3) {
        [self startIndicator];
        [self.buildingProxy searchBuildingsWithString:self.searchBar.text];
    } else {
        self.buildings = nil;
        [self.searchListVC showSearchBuildings:nil];
        [self updateUIPieces];
    }
}

- (void)startIndicator
{
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
        self.aiShouldBeSpinning = YES;
        
    }
}

- (void)stopIndicator
{
    [self.activityIndicator stopAnimating];
    self.aiShouldBeSpinning = NO;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
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
