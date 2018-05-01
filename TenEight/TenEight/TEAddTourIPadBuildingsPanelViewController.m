//
//  TEAddTourIPadBuildingsPanelViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/18/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEAddTourIPadBuildingsPanelViewController.h"
#import "TEBuildingSearchListViewController.h"

@interface TEAddTourIPadBuildingsPanelViewController ()

@end

@implementation TEAddTourIPadBuildingsPanelViewController

@synthesize buildingsArea;
@synthesize buildingsSearchArea;
@synthesize buildingsController;
@synthesize buildingsSearchListController;
@synthesize activityIndicator;
@synthesize tourID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showBuildingsInTourDetails:(NSInteger)_tourID
{
    self.tourID = _tourID;
    [self.buildingsController loadBuildingsInTour:self.tourID];
}

- (void)showBuildingsInSearch:(NSArray *)searchBuildings
{
    [self.buildingsSearchListController showSearchBuildings:searchBuildings];
}

- (void)didSelectBuildingFromList:(TEBuildingInfo *)searchBuilding
{
    // user has selected a building from the search buildings list
    if ([self.delegate respondsToSelector:@selector(didSelectBuildingFromSearch:)]) {
        [self.delegate didSelectBuildingFromSearch:searchBuilding];
    }
}

- (void)needEditBuilding:(TEBuildingInfoInTour *)building inTour:(NSInteger)tid
{
    if ([self.delegate respondsToSelector:@selector(needEditBuilding:inTour:)]) {
        [self.delegate needEditBuilding:building inTour:tid];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.buildingsSearchListController = [[TEBuildingSearchListViewController alloc] init];
    self.buildingsSearchListController.cellType = CellTypeAdd;
    self.buildingsSearchListController.delegate = self;
    [[self.buildingsSearchArea subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buildingsSearchListController.view setFrame:CGRectMake(0, 0, self.buildingsSearchArea.frame.size.width, self.buildingsSearchArea.frame.size.height)];
    [self.buildingsSearchArea addSubview:self.buildingsSearchListController.view];
    
    self.buildingsController = [[TEBuildingListViewController alloc] init];
    self.buildingsController.delegate = self;
    [[self.buildingsArea subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.buildingsArea.frame.size.width, self.buildingsArea.frame.size.height) style:UITableViewStylePlain];
    table.dataSource = self.buildingsController;
    table.delegate = self.buildingsController;
    self.buildingsController.buildingTableView = table;
    self.buildingsController.buildingListType = BuildingListWithOptions;
    [self.buildingsArea addSubview:table];
    UIActivityIndicatorView *aim = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    [aim setFrame:CGRectMake((self.buildingsArea.frame.size.width - 36)/2, (self.buildingsArea.frame.size.height - 36)/2, 37, 37)];
    [aim setColor:[UIColor colorWithRed:101/255.0 green:2/255.0 blue:0/255.0 alpha:1]];
    self.buildingsController.activityIndicator = aim;
    [self.buildingsArea addSubview:aim];

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


- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSString *errordesc = [((NSError *)error) localizedDescription];
    if ([error code]==4) {
        errordesc  = @"Network error.  The connection was blocked (you may need to first log in to the wireless network) or the server has failed to respond.";
    }
    [self provideMessage:errordesc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end
