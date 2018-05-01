//
//  TEPhotoAreaViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEPhotoAreaViewController.h"
#import "TEPhotoGridViewCell.h"


@interface TEPhotoAreaViewController ()

enum
{
    ImageDemoCellTypePlain,
    ImageDemoCellTypeFill,
    ImageDemoCellTypeOffset
};



@end

@implementation TEPhotoAreaViewController

@synthesize photoListView;
@synthesize noPhotoView;
@synthesize cellSize;
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

    self.photoProxy = [[TEPhotoProxy alloc] init];
    self.photoProxy.delegate = self;

    self.cellSize = [self.delegate cellSize];
    self.photoListView.backgroundColor = [UIColor whiteColor];
    //self.photoListView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.photoListView.autoresizesSubviews = NO;
    self.photoListView.separatorStyle = AQGridViewCellSeparatorStyleEmptySpace;
    self.photoListView.resizesCellWidthToFit = NO;
    self.photoListView.separatorColor = [UIColor whiteColor];
    
    _cellType = ImageDemoCellTypePlain;
    
    self.photoListView.delegate = self;
	self.photoListView.dataSource = self;
    
    if ([self.photos count]>0) {
        photoListView.hidden = NO;
        noPhotoView.hidden = YES;
        [self.photoListView reloadData];
    } else {
        noPhotoView.hidden = NO;
        photoListView.hidden = YES;
    }
}


- (void) setPhotos:(NSArray *)photos
{
    noPhotoView.hidden = NO;
    photoListView.hidden = YES;

    _photos = photos;

    if (photos) {
        images = [[NSMutableArray alloc] initWithCapacity:[self.photos count]];
        self.placeholderImage = [UIImage imageNamed:@"loading"];
        for (int i=0; i<[self.photos count]; i++) {
            [images addObject:self.placeholderImage];
        }
        [self.photoListView reloadData];
        
        if ([photos count]>0) {
            noPhotoView.hidden = YES;
            photoListView.hidden = NO;
        }
    }
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
                plainCell = [[TEPhotoGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, self.cellSize.width, self.cellSize.height)
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
    
    TEPhotoGridViewCell *plainCell = (TEPhotoGridViewCell *)[inparms objectForKey:@"cell"];

    UIImage *image = [[UIImage alloc] initWithData:(NSData *)[inparms objectForKey:@"imagedata"]];
   
    NSInteger index = [[inparms objectForKey:@"index"] intValue];
    [self.images replaceObjectAtIndex:index withObject:image];
    plainCell.image = [images objectAtIndex:index];

}




- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( self.cellSize );
}


#pragma mark Grid View Delegate

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
    [self.photoListView deselectItemAtIndex:index animated:YES];
    self.selectedPhotoIndex = index;
    [self.delegate photoSelected:index];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.images = nil;
    self.placeholderImage = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end

