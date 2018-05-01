//
//  TEDocumentAreaViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBaseViewController.h"
#import "AQGridView.h"

@interface TEDocumentAreaViewController : TEBaseViewController <AQGridViewDelegate, AQGridViewDataSource, QLPreviewControllerDataSource,QLPreviewControllerDelegate, TEDocumentProxyDelegate>

{
    NSArray * _documents;
    
}

@property (nonatomic, weak) IBOutlet AQGridView *documentListView;
@property (nonatomic, weak) IBOutlet UIView *noDocumentView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray *documentInfo;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic) NSUInteger selectedDocumentIndex;
@property (nonatomic, strong) TEDocumentProxy *documentProxy;

@end
