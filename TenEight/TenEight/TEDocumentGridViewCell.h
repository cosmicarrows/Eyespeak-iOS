//
//  TEDocumentGridViewCell.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/27/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"

@interface TEDocumentGridViewCell : AQGridViewCell
{
    UIImageView * _imageView;
    UIView * _borderView;
    CGRect constantImageFrame;
    
}
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) UILabel * docName;
@end
