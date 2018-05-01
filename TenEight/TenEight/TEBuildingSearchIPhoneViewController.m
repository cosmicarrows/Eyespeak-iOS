//
//  TEBuildingSearchIPhoneViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 10/4/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEBuildingSearchIPhoneViewController.h"
#import "TEBuildingSearchListViewController.h"

@interface TEBuildingSearchIPhoneViewController ()

@end

@implementation TEBuildingSearchIPhoneViewController

@synthesize buildingsSearchArea;
@synthesize buildingsSearchListController;
@synthesize activityIndicator;

- (id)initWithCoder:(NSCoder *)aDecoder {
    // this is done in the iphone storyboard
    if ((self = [super initWithCoder:aDecoder])) {
        self.buildingProxy = [[TEBuildingProxy alloc] init];
        [self.buildingProxy setDelegate:self];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(searchBuildingsLoaded:)
                   name:@"TEBuildingProxy_SearchBuildingsUpdated"
                 object:nil];
    }
    return self;
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
    
    UIImage *buttonImage = [[UIImage imageNamed:@"button_black"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"button_black_highlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageDisabled = [[UIImage imageNamed:@"button_black_disabled.png"]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [self.doneButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.doneButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [self.doneButton setBackgroundImage:buttonImageDisabled forState:UIControlStateDisabled];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
}

- (IBAction)donePressed:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}



#pragma mark SearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchBar.text.length >= 3) {
        if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
            [self.activityIndicator startAnimating];
        }
        [self.buildingProxy searchBuildingsWithString:self.searchBar.text];
    } else {
        [self.buildingsSearchListController showSearchBuildings:nil];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)searchBuildingsLoaded:(NSNotification *)note
{
    [self.activityIndicator stopAnimating];
    
    NSDictionary *params = note.userInfo;
    BOOL success = [(NSNumber *)[params objectForKey:@"success"] boolValue];
    
    if (success) {
        [self.buildingsSearchListController showSearchBuildings:self.buildingProxy.searchBuildings];
    } else {
        NSString *message = (NSString *)[params objectForKey:@"message"];
        [self provideMessage:message];
    }
}

- (void)didSelectBuildingFromList:(TEBuildingInfo *)searchBuilding
{
    if ([self.delegate respondsToSelector:@selector(didSelectBuildingFromList:)]) {
        [self.delegate didSelectBuildingFromList:searchBuilding];
        [self donePressed:nil];
    }
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
