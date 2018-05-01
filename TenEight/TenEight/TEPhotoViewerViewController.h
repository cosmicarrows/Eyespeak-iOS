//
//  TEPhotoViewerViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEPhotoViewerViewController : TEBaseViewController <UIScrollViewDelegate, TEPhotoProxyDelegate>

@property (nonatomic, weak) IBOutlet UIButton *prevButton;
@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UILabel *countLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollback;
@property (nonatomic, strong) UIImageView *imagePhoto;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic) NSUInteger currentPhotoIndex;
@property (nonatomic, strong) TEPhotoProxy *photoProxy;

-(IBAction)prevSelected:(id)sender;
-(IBAction)nextSelected:(id)sender;
-(IBAction)handleSwipeRight:(UISwipeGestureRecognizer *)sender;
-(IBAction)handleSwipeLeft:(UISwipeGestureRecognizer *)sender;
-(IBAction)handleDoubleTap:(UITapGestureRecognizer *)sender;


@end