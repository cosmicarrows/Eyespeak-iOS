//
//  TESyncViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 10/1/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TESyncViewController.h"

@interface TESyncViewController ()

@end

@implementation TESyncViewController

@synthesize processing;
@synthesize statusInfo;
@synthesize doneStopButton;
@synthesize status;
@synthesize activityIndicator;

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
    
    [self.doneStopButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.doneStopButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [self.doneStopButton setBackgroundImage:buttonImageDisabled forState:UIControlStateDisabled];
    
}

- (void)didFinishTourDownload
{
    self.processing = NO;
    [self.activityIndicator stopAnimating];
    self.status.text = @"Sync Complete";
    [self.doneStopButton setTitle:@"Close" forState:UIControlStateNormal];
}

- (void)didErrorOutSync
{
    self.processing = NO;
    [self.activityIndicator stopAnimating];
    self.status.text = @"Connection error.  Retry.";
    [self.doneStopButton setTitle:@"Close" forState:UIControlStateNormal];
}

- (void)newStatusMessage:(NSString *)statusMessage
{
    self.statusInfo.text = [NSString stringWithFormat:@"%@\n%@", self.statusInfo.text, statusMessage];
    DDLogVerbose(@"Sync message: %@",statusMessage);
    CGPoint scrollPoint = self.statusInfo.contentOffset;
    scrollPoint.y= scrollPoint.y+20;
    [self.statusInfo setContentOffset:scrollPoint animated:NO];
}

- (void) startDownloadForTour:(NSInteger)tourID
{
    if([[[RKClient sharedClient] reachabilityObserver] isReachabilityDetermined]&&[[RKClient sharedClient] isNetworkReachable]){
        self.syncController = [[TESyncController alloc] init];
        [self.syncController setDelegate:self];
        
        self.processing = YES;
        self.status.text = @"Sync In Progress";
        if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
            [self.activityIndicator startAnimating];
        }
        self.statusInfo.text = @"";
        [self.syncController startSyncForTour:tourID];
        
    } else {
        self.status.text = @"No network connection.";
        self.processing = NO;
        [self newStatusMessage:@"Network Error.  Network not available."];
        [self newStatusMessage:@"Sync can only be performed with an active network connection."];
        [self.doneStopButton setTitle:@"Close" forState:UIControlStateNormal];
    }

}

- (IBAction)doneStopPressed:(id)sender
{
    if (self.processing) {
        self.status.text = @"Stopping...";
        self.processing = NO;
        [self.activityIndicator stopAnimating];
        [self.syncController stopProcessing];
        self.status.text = @"Stopped but not finished.";
        [self newStatusMessage:@"Stopped but not finished."];
        [self.doneStopButton setTitle:@"Close" forState:UIControlStateNormal];
    } else {
        theAppDelegate().allUIResetNeeded = true;
        if (!theAppDelegate().switchUserMode) {
            theAppDelegate().token = theAppDelegate().masterUserLoginInfo.token;
        }
        [self.delegate willDismissSyncView];
        self.syncController = nil;
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSString *errordesc = [((NSError *)error) localizedDescription];
    if ([error code]==4) {
        errordesc  = @"Network error.  The connection was blocked (you may need to first log in to the wireless network) or the server has failed to respond.";
    }

    [self provideMessage:errordesc];
    [self.activityIndicator stopAnimating];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.syncController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
    self.syncController = nil;
}



@end
