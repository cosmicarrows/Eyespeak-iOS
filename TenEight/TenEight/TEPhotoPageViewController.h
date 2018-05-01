//
//  TEPhotoPageViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/6/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "AQGridView.h"
#import "TEPhotoProxy.h"

@interface TEPhotoPageViewController : TEBaseViewController <AQGridViewDelegate, AQGridViewDataSource, TEPhotoProxyDelegate>

{
    NSArray * _imageNames;
    
    NSUInteger _cellType;

}

@property (nonatomic, strong) IBOutlet AQGridView *photoListView;
@property (nonatomic, strong) IBOutlet UIView *noPhotoView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) NSNumber* buildingID;
@property (nonatomic) NSUInteger selectedPhotoIndex;
@property (nonatomic, strong) TEPhotoProxy *photoProxy;

@end
