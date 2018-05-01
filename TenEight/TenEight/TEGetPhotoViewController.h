//
//  TEGetPhotoViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/11/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TEGetPhotoViewControllerDelegate <NSObject>
-(void) photoAcquireCancelled;
-(void) photoAcquireUpload:(UIImage *)image;
@end


@interface TEGetPhotoViewController : TEBaseViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *photoButton;
@property (nonatomic, weak) IBOutlet UIButton *libraryButton;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UIButton *uploadButton;
@property (nonatomic, weak) IBOutlet UILabel *noOptionsAvailable;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollback;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;


@property (nonatomic, weak) id<TEGetPhotoViewControllerDelegate> delegate;

-(IBAction)photoSelected:(id)sender;
-(IBAction)librarySelected:(id)sender;
-(IBAction)cancelSelected:(id)sender;
-(IBAction)uploadSelected:(id)sender;

@end
