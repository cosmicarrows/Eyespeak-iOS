//
//  TETabBarController.m
//  TenEight
//
//  Created by Brad Wiederholt on 8/29/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TETabBarController.h"
#import "TEPreferencesViewController.h"
#import "TEBuildingIPadDetailViewController.h"
#import "TEFrameNavViewController.h"

@interface TETabBarController ()

@end

@implementation TETabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(loggedIn:)
                   name:@"LoggedIn"
                 object:nil];
        [nc addObserver:self
               selector:@selector(logout:)
                   name:@"LogUserOut"
                 object:nil];
        [nc addObserver:self
               selector:@selector(presentPreferences:)
                   name:@"ShowPreferences"
                 object:nil];
        [nc addObserver:self
               selector:@selector(buildingDetailsView:)
                   name:@"ShowBuildingDetails"
                 object:nil];
        [nc addObserver:self
               selector:@selector(showTours:)
                   name:@"ShowTours"
                 object:nil];

    }
    return self;
}

- (void) hideTabBar {
    for(UIView *view in self.view.subviews)
    {
        CGRect _rect = view.frame;
        if([view isKindOfClass:[UITabBar class]])
        {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                _rect.origin.y = [ [ UIScreen mainScreen ] bounds ].size.height;
                [view setFrame:_rect];
            } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                _rect.origin.y = 1024;
                [view setFrame:_rect];
            }
        } else {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                _rect.size.height = [ [ UIScreen mainScreen ] bounds ].size.height;
                [view setFrame:_rect];
            } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                _rect.size.height = 1024;
                [view setFrame:_rect];
            }
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self hideTabBar];
    [self blankView];
    
    if (theAppDelegate().masterUserLoginInfo) {
        // we can be in a reload situation when there was a memory warning issued and we were kicked back to the root
        [self toursView];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    if (!theAppDelegate().masterUserLoginInfo) {
        [self.storyboard instantiateViewControllerWithIdentifier:@"sbTELoginViewController"];
        [self performSegueWithIdentifier:@"sbLoginSegue" sender:nil];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}


- (void)toursView
{
    [self setSelectedIndex:1];
    [self setTitle:@"TOURS"];
}

- (void)buildingsView
{
    [self setSelectedIndex:2];
    [self setTitle:@"BUILDINGS"];
}

-(void)showTours:(NSNotification *)note
{
    [self toursView];
}

-(void)buildingDetailsView:(NSNotification *)note
{

    NSDictionary *params = note.userInfo;
    
    DDLogVerbose(@"note: %@", note);
    DDLogVerbose(@"params: %@", params);

    [self.storyboard instantiateViewControllerWithIdentifier:@"sbBuildingIPadDetailViewController"];
    
    for (UIViewController *ov in self.viewControllers)
    {
        UIViewController *ovc = ov;
        if ([ovc isKindOfClass:[TEFrameNavViewController class]])
        {
            TEFrameNavViewController *fnVC = (TEFrameNavViewController *)ovc;
            
            for (UIViewController *v in fnVC.viewControllers)
            {
                UIViewController *vc = v;
                
                
                if ([vc isKindOfClass:[TEBuildingIPadDetailViewController class]])
                {
                    TEBuildingIPadDetailViewController *detailVC = (TEBuildingIPadDetailViewController *)vc;
                    
                    TEBuildingInfoInTour *selectedBuilding = (TEBuildingInfoInTour *)[params objectForKey:@"selectedBuilding"];
                    TETourInfo *tour = (TETourInfo *)[params objectForKey:@"tour"];
                    DDLogVerbose(@"selectedBuilding: %@", selectedBuilding);
                    DDLogVerbose(@"tour: %@", tour);
                    
                    [detailVC setBuilding:selectedBuilding];
                    [detailVC setTour:tour];
                    [detailVC presentNewBuilding:selectedBuilding.buildingID inTour:tour.tourID];
                    
                }
            }
        }
    }
    
    
    [self setSelectedIndex:3];
}


- (void)preferencesView
{
    [self.storyboard instantiateViewControllerWithIdentifier:@"sbTEPreferencesViewController"];
    [self performSegueWithIdentifier:@"sbPreferencesSegue" sender:nil];
}

- (void)logoutView
{
    [self.storyboard instantiateViewControllerWithIdentifier:@"sbTELoginViewController"];
    [self performSegueWithIdentifier:@"sbLoginSegue" sender:nil];
}

- (void)blankView
{
    [self setSelectedIndex:0];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sbPreferencesSegue"]) {
        
        TEPreferencesViewController *controller = (TEPreferencesViewController *)segue.destinationViewController;
        [controller loadPreferences];
    }
}

-(void)loggedIn:(NSNotification *)note
{
    // default to toursView when we log in
    [self toursView];
}

- (void)presentPreferences:(NSNotification *)note
{
    [self preferencesView];
}

- (void)logout:(NSNotification *)note
{
    [self blankView];
    [self logoutView];
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

-(NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return UIInterfaceOrientationMaskPortrait;
    else  /* ipad */
        return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
