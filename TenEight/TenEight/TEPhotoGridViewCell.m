/*
 * TEPhotoGridViewCell.m
 */

#import "TEPhotoGridViewCell.h"
#import "DDLog.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"

@implementation TEPhotoGridViewCell

- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) aReuseIdentifier
{
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    if ( self == nil )
        return ( nil );

    [self.contentView setContentMode:UIViewContentModeCenter];
    
    
    constantImageFrame = CGRectMake(frame.origin.x+2, frame.origin.y+2, frame.size.width - 4, frame.size.height - 4);

    _borderView = [[UIImageView alloc] initWithFrame: constantImageFrame];
    [_borderView setContentMode:UIViewContentModeCenter];
    [_borderView setClipsToBounds:YES];
    _borderView.autoresizesSubviews = NO;

    _imageView = [[UIImageView alloc] initWithFrame: constantImageFrame];

    [_imageView setContentMode:UIViewContentModeCenter];
    [_imageView setClipsToBounds:YES];
    _imageView.autoresizesSubviews = NO;
    
    [self.contentView addSubview:_borderView];
    [_borderView addSubview:_imageView];
    
    
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
//    _imageView.image = anImage;
    
    float resizeWidthRatio = _imageView.frame.size.width / anImage.size.width;
    float resizeHeightRatio = _imageView.frame.size.height / anImage.size.height;
    float resizeFactor = MAX(resizeWidthRatio, resizeHeightRatio);
    
    DDLogVerbose (@"_imageView.frame w=%f h=%f",_imageView.frame.size.width, _imageView.frame.size.height);
    DDLogVerbose (@"anImage w=%f h=%f",anImage.size.width, anImage.size.height);
    CGSize newSize = CGSizeMake(anImage.size.width*resizeFactor, anImage.size.height*resizeFactor);
    UIGraphicsBeginImageContext(newSize);
    [anImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _imageView.image = smallImage;

    [self setNeedsLayout];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
//    UIImage *originalImage = _imageView.image;
//    CGSize destinationSize = constantImageFrame.size;
//    
//    UIGraphicsBeginImageContext(destinationSize);
//    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    _imageView.image = newImage;

}

@end
