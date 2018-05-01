//
//  TEPhotoStreamViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/11/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEPhotoStreamViewController.h"

@interface TEPhotoStreamViewController ()

@end

@implementation TEPhotoStreamViewController

@synthesize imagePhoto, scrollback, countLabel;
@synthesize currentPhotoIndex;
@synthesize photos;
@synthesize prevButton, nextButton;
@synthesize activityIndicator;



- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.photoProxy = [[TEPhotoProxy alloc] init];
        self.photoProxy.delegate = self;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self changeToiPhoneBaseBarItemsWithSwitchUser];
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapRecognizer];
    
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeRecognizer];
    
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeRecognizer];
    
    [self.activityIndicator stopAnimating];
    
    UIImage *nextImage = [UIImage imageNamed:@"arrow_forward"];
    UIImage *nextImageDisabled = [UIImage imageNamed:@"arrow_forward_disabled"];
    UIImage *prevImage = [UIImage imageNamed:@"arrow_back"];
    UIImage *prevImageDisabled = [UIImage imageNamed:@"arrow_back_disabled"];
    [nextButton setBackgroundImage:nextImage forState:UIControlStateNormal];
    [nextButton setBackgroundImage:nextImageDisabled forState:UIControlStateDisabled];
    [prevButton setBackgroundImage:prevImage forState:UIControlStateNormal];
    [prevButton setBackgroundImage:prevImageDisabled forState:UIControlStateDisabled];

    [self updateUI];

}



- (void)updateUI
{
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
    }
    
    if (currentPhotoIndex == 0) {
        self.prevButton.enabled = NO;
    } else {
        self.prevButton.enabled = YES;
    }
    if (currentPhotoIndex+1 >= [self.photos count]) {
        self.nextButton.enabled = NO;
    } else {
        self.nextButton.enabled = YES;
    }
    

    // remove everything in the scrollview
    for(UIView *subview in [self.scrollback subviews]) {
        [subview removeFromSuperview];
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"%d of %d",self.currentPhotoIndex+1, [self.photos count]];

    
	//Get image and make an image view, and add to scrollview
    NSInteger photoID = [((TEPhotoInfo *)[self.photos objectAtIndex:self.currentPhotoIndex]).photoID intValue];
    
    [self performSelectorInBackground:@selector(loadImageInBackground:) withObject:[NSNumber numberWithInt: photoID ]];
    
}

- (void) assignDataToImageView:(NSData *)imgData
{
    UIImage *image = [[UIImage alloc] initWithData:imgData];
    self.imagePhoto = [[UIImageView alloc] initWithImage:image];
    [scrollback addSubview:self.imagePhoto];
    // Setup the sizes based on content
    self.scrollback.contentSize = self.imagePhoto.image.size;
    
    float widthRatio = self.scrollback.bounds.size.width / self.imagePhoto.image.size.width;
    float heightRatio = self.scrollback.bounds.size.height / self.imagePhoto.image.size.height;
    [self.scrollback setZoomScale:MIN(widthRatio, heightRatio)];
    DDLogVerbose(@"widthRatio = %f", widthRatio);
    DDLogVerbose(@"heightRatio = %f", heightRatio);
    DDLogVerbose(@"MAX = %f", MIN(widthRatio, heightRatio));
    DDLogVerbose(@"zoomscale = %f", self.scrollback.zoomScale);
    
    [self.activityIndicator stopAnimating];
}


- (void) loadImageInBackground:(NSNumber *)photoID
{
    
    NSData *imagedata = [self.photoProxy getPhoto:[photoID intValue] ofType:PhotoTypeLarge];
    [self performSelectorOnMainThread:@selector(assignDataToImageView:) withObject:imagedata waitUntilDone:NO];
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIView *subView = [scrollView.subviews objectAtIndex:0];
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

- (IBAction)handleSwipeRight:(UISwipeGestureRecognizer *)sender
{
    [self prevSelected:sender];
}

- (IBAction)handleSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    [self nextSelected:sender];
}

- (IBAction)handleDoubleTap:(UITapGestureRecognizer *)sender
{
    self.scrollback.contentSize = self.imagePhoto.image.size;
    
    float widthRatio = self.scrollback.bounds.size.width / self.imagePhoto.image.size.width;
    float heightRatio = self.scrollback.bounds.size.height / self.imagePhoto.image.size.height;
    [self.scrollback setZoomScale:MIN(widthRatio, heightRatio) animated:YES];
}





- (void)prevSelected:(id)sender
{
    if (self.currentPhotoIndex > 0) {
        self.currentPhotoIndex -= 1;
    }
    [self updateUI];

}
- (void)nextSelected:(id)sender
{
    if (self.currentPhotoIndex < ([self.photos count]-1)) {
        self.currentPhotoIndex += 1;
    }
    [self updateUI];

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imagePhoto;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.imagePhoto = nil;
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSString *errordesc = [((NSError *)error) localizedDescription];
    if ([error code]==4) {
        errordesc  = @"Network error.  The connection was blocked (you may need to first log in to the wireless network) or the server has failed to respond.";
    }

    [self provideMessage:errordesc];
    [self.activityIndicator stopAnimating];
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
