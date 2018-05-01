//
//  TEPhotoPageViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/6/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEPhotoPageViewController.h"

#import "TEPhotoGridViewCell.h"
#import "ImageDemoFilledCell.h"
#import "TEPhotoStreamViewController.h"
#import "TEPhotoProxy.h"

#define PHOTOCELLWIDTH      106
#define PHOTOCELLHEIGHT     106

@interface TEPhotoPageViewController ()

@end

enum
{
    ImageDemoCellTypePlain,
    ImageDemoCellTypeFill,
    ImageDemoCellTypeOffset
};


@implementation TEPhotoPageViewController

@synthesize photoListView, noPhotoView;
@synthesize buildingID;
@synthesize activityIndicator;
@synthesize selectedPhotoIndex;
@synthesize photos = _photos;
@synthesize images;
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
    

    self.photoProxy = [[TEPhotoProxy alloc] init];
    self.photoProxy.delegate = self;
    
    self.photoListView.backgroundColor = [UIColor whiteColor];
    //self.photoListView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.photoListView.autoresizesSubviews = NO;
    self.photoListView.separatorStyle = AQGridViewCellSeparatorStyleEmptySpace;
    self.photoListView.resizesCellWidthToFit = NO;
    self.photoListView.separatorColor = [UIColor greenColor];

    _cellType = ImageDemoCellTypePlain;

    self.photoListView.delegate = self;
	self.photoListView.dataSource = self;

    if ([self.photos count]>0) {
        [self.photoListView reloadData];
    }
    
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.activityIndicator stopAnimating];
}

- (void)updateUI
{
    if ([self.photos count]>0) {
        photoListView.hidden = NO;
        noPhotoView.hidden = YES;
    } else {
        photoListView.hidden = YES;
        noPhotoView.hidden = NO;
    }
}

- (void) setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (photos) {
        images = [[NSMutableArray alloc] initWithCapacity:[self.photos count]];
        self.placeholderImage = [UIImage imageNamed:@"loading"];
        for (int i=0; i<[self.photos count]; i++) {
            [images addObject:self.placeholderImage];
        }
        [self.photoListView reloadData];
        [self updateUI];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.images = nil;
    self.placeholderImage = nil;
}


#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return ( [self.photos count] );
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    
    AQGridViewCell * cell = nil;
    
    switch ( _cellType )
    {
        case ImageDemoCellTypePlain:
        {
            TEPhotoGridViewCell * plainCell = (TEPhotoGridViewCell *)[aGridView dequeueReusableCellWithIdentifier: PlainCellIdentifier];
            if ( plainCell == nil )
            {
                plainCell = [[TEPhotoGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, PHOTOCELLWIDTH, PHOTOCELLHEIGHT)
                                                         reuseIdentifier: PlainCellIdentifier];
                plainCell.selectionGlowColor = [UIColor whiteColor];
            }
            
            
            if ([self.images objectAtIndex:index] != placeholderImage) {
                plainCell.image = [images objectAtIndex:index];
            } else {
                plainCell.image = placeholderImage;
                NSNumber *photoID = ((TEPhotoInfo *)[self.photos objectAtIndex:index]).photoID;
                NSMutableDictionary * parms = [NSMutableDictionary dictionaryWithObjectsAndKeys:photoID, @"photoid", plainCell, @"cell", [NSNumber numberWithInt:index], @"index", nil];
                [self performSelectorInBackground:@selector(loadImageInBackground:) withObject:parms];

            }
          

            cell = plainCell;
            break;
        }
            
            
        default:
            break;
    }
    
    return ( cell );
}



- (void) loadImageInBackground:(NSMutableDictionary *)inparms
{
    
    NSData *imagedata = [self.photoProxy
                         getPhoto:[(NSNumber *)[inparms objectForKey:@"photoid"] intValue]
                         ofType:PhotoTypeThumb];
    
    if (imagedata) {
        [inparms setObject:imagedata forKey:@"imagedata"];
        
        [self performSelectorOnMainThread:@selector(assignDataToImageView:) withObject:inparms waitUntilDone:NO];
    }

}



- (void) assignDataToImageView:(NSMutableDictionary *)inparms
{
    
    TEPhotoGridViewCell *cell = (TEPhotoGridViewCell *)[inparms objectForKey:@"cell"];
    
    UIImage *image = [[UIImage alloc] initWithData:(NSData *)[inparms objectForKey:@"imagedata"]];
    
    
    NSInteger index = [[inparms objectForKey:@"index"] intValue];
    [self.images replaceObjectAtIndex:index withObject:image];
    cell.image = [images objectAtIndex:index];
    
}







- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(PHOTOCELLWIDTH, PHOTOCELLHEIGHT) );
}


#pragma mark Grid View Delegate

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
    }
    
    [self.photoListView deselectItemAtIndex:index animated:YES];
    
    self.selectedPhotoIndex = index;

    //[self.storyboard instantiateViewControllerWithIdentifier:@"sbPhotoStreamViewController"];
    [self performSegueWithIdentifier:@"sbViewPhotoSegue" sender:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sbViewPhotoSegue"]) {
        
//        TEPhotoStreamViewController *controller = (TEPhotoStreamViewController *)segue.destinationViewController;
        TEPhotoStreamViewController *controller = (TEPhotoStreamViewController *)segue.destinationViewController;

        [controller setPhotos:self.photos];
        [controller setCurrentPhotoIndex:self.selectedPhotoIndex];
        
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
