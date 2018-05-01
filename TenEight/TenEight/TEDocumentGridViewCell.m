//
//  TEDocumentGridViewCell.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/27/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEDocumentGridViewCell.h"

@implementation TEDocumentGridViewCell

@synthesize docName;
@synthesize image;

#define LABEL_HEIGHT 15
#define VERTICAL_GAP 25

- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) aReuseIdentifier
{
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    if ( self == nil )
        return ( nil );
    
    [self.contentView setContentMode:UIViewContentModeCenter];
    //    [self.contentView setClipsToBounds:YES];
    
    
    constantImageFrame = CGRectMake(frame.origin.x + 10, frame.origin.y+2, frame.size.width - 54, frame.size.height -2 - LABEL_HEIGHT - VERTICAL_GAP);
    
    _borderView = [[UIImageView alloc] initWithFrame: constantImageFrame];
    _borderView.autoresizesSubviews = YES;
    [_borderView setContentMode:UIViewContentModeCenter];
    [_borderView setClipsToBounds:NO];
    _borderView.autoresizesSubviews = NO;
    
    _imageView = [[UIImageView alloc] initWithFrame: _borderView.frame];
    
    [_imageView setContentMode:UIViewContentModeCenter];
    [_imageView setClipsToBounds:YES];
    _imageView.autoresizesSubviews = NO;
    
    [self.contentView addSubview:_borderView];
    [_borderView addSubview:_imageView];
    
    docName = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x+2, frame.size.height - LABEL_HEIGHT - VERTICAL_GAP, frame.size.width - 4, LABEL_HEIGHT)];
    docName.textAlignment =  UITextAlignmentCenter;
    docName.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(11.0)];
    [self.contentView addSubview:self.docName];
        
    return ( self );
}


- (CALayer *) glowSelectionLayer
{
    return ( _imageView.layer );
}

- (UIImage *) image
{
    return ( _imageView.image );
}

- (void) setImage: (UIImage *) anImage
{
    _imageView.image = anImage;
    [self setNeedsLayout];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    UIImage *originalImage = _imageView.image;
    CGSize destinationSize = constantImageFrame.size;
    
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _imageView.image = newImage;

}

@end
