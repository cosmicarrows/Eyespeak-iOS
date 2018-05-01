//
//  TEAddTourIPadMembersPanelViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/18/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEAddTourIPadMembersPanelViewController.h"

@interface TEAddTourIPadMembersPanelViewController ()

@end

@implementation TEAddTourIPadMembersPanelViewController

@synthesize membersArea;
@synthesize membersController;
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

- (void)showMemberDetails:(NSInteger)_tourID
{
    self.tourID = _tourID;
    [self.membersController loadMembersInTour:self.tourID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.membersController = [[TEMembersListViewController alloc] init];
    
    [[self.membersArea subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 472, 661) style:UITableViewStylePlain];
    table.dataSource = self.membersController;
    table.delegate = self.membersController;
    self.membersController.memberTableView = table;
    [self.membersArea addSubview:table];
    UIActivityIndicatorView *aim = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    [aim setFrame:CGRectMake((self.membersArea.frame.size.width - 36)/2, (self.membersArea.frame.size.height - 36)/2, 37, 37)];
    [aim setColor:[UIColor colorWithRed:101/255.0 green:2/255.0 blue:0/255.0 alpha:1]];
    self.membersController.activityIndicator = aim;
    [self.membersArea addSubview:aim];}


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
