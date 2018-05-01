//
//  TEPhotoAcquireViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEPhotoAcquireViewController.h"

#define MAX_EDGE 1000

@interface TEPhotoAcquireViewController ()

@end

@implementation TEPhotoAcquireViewController

@synthesize delegate;
@synthesize photoButton;
@synthesize libraryButton;
@synthesize cancelButton;
@synthesize uploadButton;
@synthesize noOptionsAvailable;
@synthesize imageView, scrollback;
@synthesize activityIndicator;
@synthesize libraryPopover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)cancelSelected:(id)sender
{
    [delegate photoAcquireCancelled];
}

- (void)uploadSelected:(id)sender
{
    [delegate photoAcquireUpload:self.imageView.image];
}

- (void)photoSelected:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        [imagePicker setDelegate:self];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}



- (void)librarySelected:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [imagePicker setDelegate:self];
        
        self.libraryPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [self.libraryPopover presentPopoverFromRect:self.libraryButton.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    }
    
}



- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    scrollback.hidden = NO;
    uploadButton.hidden = NO;
    
    
    // remove everything in the scrollview
    for(UIView *subview in [self.scrollback subviews]) {
        [subview removeFromSuperview];
    }
    
    
	//Get image and make an image view, and add to scrollview
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    float resizeWidthRatio = image.size.width / MAX_EDGE;
    float resizeHeightRatio = image.size.height / MAX_EDGE;
    float resizeFactor = MAX(resizeWidthRatio, resizeHeightRatio);
    
    CGSize newSize = CGSizeMake(MAX_EDGE*resizeWidthRatio/resizeFactor, MAX_EDGE*resizeHeightRatio/resizeFactor);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageView = [[UIImageView alloc] initWithImage:smallImage];
    
    [scrollback addSubview:self.imageView];
    
    
    // Setup the sizes based on content
    self.scrollback.contentSize = self.imageView.image.size;
    
    float widthRatio = self.scrollback.bounds.size.width / self.imageView.image.size.width;
    float heightRatio = self.scrollback.bounds.size.height / self.imageView.image.size.height;
    [self.scrollback setZoomScale:MAX(widthRatio, heightRatio)];
    
    if (self.libraryPopover) {
        [self.libraryPopover dismissPopoverAnimated:YES];
        self.libraryPopover = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"button_silver"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"button_silver_highlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *cancelButtonImage = [[UIImage imageNamed:@"button_black"]
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *cancelButtonImageHighlight = [[UIImage imageNamed:@"button_black_highlight.png"]
                                           resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *cancelButtonImageDisabled = [[UIImage imageNamed:@"button_black_disabled.png"]
                                          resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [photoButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [photoButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [libraryButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [libraryButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [uploadButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [uploadButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [cancelButton setBackgroundImage:cancelButtonImage forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:cancelButtonImageHighlight forState:UIControlStateHighlighted];
    [cancelButton setBackgroundImage:cancelButtonImageDisabled forState:UIControlStateDisabled];
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.photoButton.hidden = YES;
    }
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.libraryButton.hidden = YES;
    }
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.noOptionsAvailable.hidden = NO;
    }
    
    self.libraryButton.hidden = NO;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
//        self.libraryButton.hidden = YES;
//    }

    
    scrollback.hidden = YES;
    uploadButton.hidden = YES;
    
    [self.activityIndicator stopAnimating];
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.imageView = nil;
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
    [self.activityIndicator stopAnimating];
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
