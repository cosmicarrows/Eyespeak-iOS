//
//  TEPhotoAreaViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "AQGridView.h"

@protocol TEPhotoAreaViewControllerDelegate
- (void)photoSelected:(NSInteger)index;
- (CGSize)cellSize;
@end


@interface TEPhotoAreaViewController : TEBaseViewController <AQGridViewDelegate, AQGridViewDataSource, TEPhotoProxyDelegate>

{
    NSArray * _imageNames;
    
    NSUInteger _cellType;
    
}
@property (nonatomic, weak) id <TEPhotoAreaViewControllerDelegate> delegate;
@property (nonatomic) CGSize cellSize;

@property (nonatomic, weak) IBOutlet AQGridView *photoListView;
@property (nonatomic, weak) IBOutlet UIView *noPhotoView;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic) NSUInteger selectedPhotoIndex;
@property (nonatomic, strong) TEPhotoProxy *photoProxy;


@end
