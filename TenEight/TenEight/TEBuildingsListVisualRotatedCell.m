//
//  TEBuildingsListIPadCell.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/7/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEBuildingsListVisualRotatedCell.h"

@implementation TEBuildingsListVisualRotatedCell

@synthesize primaryLabel;
@synthesize secondaryLabel;
@synthesize myImageView;
@synthesize image=_image;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setImage:(UIImage *)image
{
    self.myImageView.image = image;

    
    float resizeWidthRatio = myImageView.frame.size.width / image.size.width;
    float resizeHeightRatio = myImageView.frame.size.height / image.size.height;
    float resizeFactor = MIN(MAX(resizeWidthRatio, resizeHeightRatio),1);
    
    CGSize newSize = CGSizeMake(image.size.width*resizeFactor, image.size.height*resizeFactor);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.myImageView.image = smallImage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
