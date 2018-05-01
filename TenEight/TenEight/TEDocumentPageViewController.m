//
//  TEDocumentPageViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/14/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//


#import "TEDocumentPageViewController.h"
#import "TEDocumentGridViewCell.h"

@interface TEDocumentPageViewController ()

@end

@implementation TEDocumentPageViewController


#define THUMBNAILWIDTH      150
#define THUMBNAILHEIGHT     140


enum
{
    ImageDemoCellTypePlain,
    ImageDemoCellTypeFill,
    ImageDemoCellTypeOffset
};


@synthesize documentListView, noDocumentView;
@synthesize buildingID;
@synthesize activityIndicator;
@synthesize selectedDocumentIndex;
@synthesize documentInfo = _documentInfo;
@synthesize placeholderImage;

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
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self changeToiPhoneBaseBarItemsWithSwitchUser];
    }
    

    self.documentProxy = [[TEDocumentProxy alloc] init];
    self.documentProxy.delegate = self;
    
    self.documentListView.backgroundColor = [UIColor whiteColor];
	self.documentListView.autoresizesSubviews = YES;
    self.documentListView.separatorStyle = AQGridViewCellSeparatorStyleEmptySpace;
    self.documentListView.resizesCellWidthToFit = YES;
    self.documentListView.separatorColor = [UIColor whiteColor];
    
    self.documentListView.delegate = self;
	self.documentListView.dataSource = self;
    
    if ([self.documentInfo count]>0) {
        [self.documentListView reloadData];
    }
    
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.activityIndicator stopAnimating];
}

- (void)updateUI
{
    if ([self.documentInfo count]>0) {
        documentListView.hidden = NO;
        noDocumentView.hidden = YES;
    } else {
        documentListView.hidden = YES;
        noDocumentView.hidden = NO;
    }
}

- (void) setDocumentInfo:(NSArray *)documentInfo
{
    _documentInfo = documentInfo;
    
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
    }
    
    [self.documentListView reloadData];
    [self updateUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.documentInfo = nil;
    self.placeholderImage = nil;
}


#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return ( [self.documentInfo count] );
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * DocCellIdentifier = @"DocCellIdentifier";
    
    AQGridViewCell * cell = nil;
    
    TEDocumentGridViewCell * docCell = (TEDocumentGridViewCell *)[aGridView dequeueReusableCellWithIdentifier: DocCellIdentifier];
    if ( docCell == nil )
    {
        docCell = [[TEDocumentGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, THUMBNAILWIDTH, THUMBNAILHEIGHT)
                                               reuseIdentifier: DocCellIdentifier];
        docCell.selectionGlowColor = [UIColor whiteColor];
    }
    
    NSArray *parts = [((TEDocumentInfo *)[self.documentInfo objectAtIndex:index]).document componentsSeparatedByString:@"/"];
    NSString *docName = [[parts lastObject] lowercaseString];
    docCell.image = [self getThumbnailForType:docName];
    docCell.docName.text = docName;
    
    
    cell = docCell;

    return ( cell );
}


- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(THUMBNAILWIDTH, THUMBNAILHEIGHT) );
}


#pragma mark Grid View Delegate

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
    [self.documentListView deselectItemAtIndex:index animated:YES];
    
    self.selectedDocumentIndex = index;
    
    QLPreviewController *previewController=[[QLPreviewController alloc]init];
    previewController.delegate=self;
    previewController.dataSource=self;
    previewController.currentPreviewItemIndex = 0;
    
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
    }
    
    [self presentViewController:previewController animated:YES completion:nil];
    DDLogVerbose(@"set current preview index: %d",previewController.currentPreviewItemIndex);

}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    
    NSInteger documentID = [((TEDocumentInfo *)[self.documentInfo objectAtIndex:self.selectedDocumentIndex]).documentID intValue];
    
    NSString *localFilePath = [self.documentProxy getPathForDocument:documentID];
    
    
    return [NSURL fileURLWithPath:localFilePath];

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

- (UIImage *)getThumbnailForType:(NSString *)docName
{
    NSArray *parts = [docName componentsSeparatedByString:@"."];
    NSString *extension = [[parts lastObject] lowercaseString];
    
    if ([extension isEqualToString:@"pdf"])
        return [UIImage imageNamed:@"19_pdf"];
    if ([extension isEqualToString:@"doc"])
        return [UIImage imageNamed:@"19_word"];
    if ([extension isEqualToString:@"docx"])
        return [UIImage imageNamed:@"19_word"];
    if ([extension isEqualToString:@"ppt"])
        return [UIImage imageNamed:@"19_powerpoint"];
    if ([extension isEqualToString:@"xls"])
        return [UIImage imageNamed:@"19_excel"];
    return [UIImage imageNamed:@"unknown"];
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

