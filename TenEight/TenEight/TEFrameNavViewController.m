//
//  TEFrameNavViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 8/29/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEFrameNavViewController.h"

@interface TEFrameNavViewController ()

@end

@implementation TEFrameNavViewController

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

    UINavigationBar *navBar = [self navigationBar];
    
    // The iPad has custom graphics we need to load
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIImage *toolBarIMG = [UIImage imageNamed: @"iPadHeaderWithLogo"];
        [navBar setBackgroundImage:toolBarIMG forBarMetrics:UIBarMetricsDefault];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIImage *toolBarIMG = [UIImage imageNamed: @"4_bg"];
        [navBar setBackgroundImage:toolBarIMG forBarMetrics:UIBarMetricsDefault];
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

-(NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return UIInterfaceOrientationMaskPortrait;
    else  /* ipad */
        return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end
