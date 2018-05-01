//
//  TEBuildingsListIPadCell.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/7/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEBuildingsListVisualRotatedCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *primaryLabel;
@property(nonatomic,strong) IBOutlet UILabel *secondaryLabel;
@property(nonatomic,strong) IBOutlet UIImageView *myImageView;

@property(nonatomic,strong)UIImage *image;

@end
