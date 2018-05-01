//
//  TESettingsPopoverViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 8/30/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TESettingsPopoverViewController.h"

@interface TESettingsPopoverViewController ()

@end

@implementation TESettingsPopoverViewController

@synthesize delegate;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)showPreferences:(id)sender
{
    [self.delegate showPreferences];
}

- (void)logout:(id)sender
{
    [self.delegate logout];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return ((interfaceOrientation == UIInterfaceOrientationPortrait) ||
                (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
    }
    else
    {
        
        return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
                (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
    }
}

@end
