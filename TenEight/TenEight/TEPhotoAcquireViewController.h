//
//  TEPhotoAcquireViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TEPhotoAcquireViewControllerDelegate <NSObject>
-(void) photoAcquireCancelled;
-(void) photoAcquireUpload:(UIImage *)image;
@end


@interface TEPhotoAcquireViewController : TEBaseViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *photoButton;
@property (nonatomic, weak) IBOutlet UIButton *libraryButton;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UIButton *uploadButton;
@property (nonatomic, weak) IBOutlet UILabel *noOptionsAvailable;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollback;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIPopoverController *libraryPopover;
@property (nonatomic, weak) id<TEPhotoAcquireViewControllerDelegate> delegate;

-(IBAction)photoSelected:(id)sender;
-(IBAction)librarySelected:(id)sender;
-(IBAction)cancelSelected:(id)sender;
-(IBAction)uploadSelected:(id)sender;

@end
