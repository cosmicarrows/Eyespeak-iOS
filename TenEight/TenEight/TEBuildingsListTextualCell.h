//
//  TETEBuildingsListTextualCell.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/19/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TEBuildingsListTextualCellDelegate <NSObject>
@optional
- (void)didSelectView:(NSInteger)itemId;
- (void)didSelectEdit:(NSInteger)itemId;
- (void)didSelectDelete:(NSInteger)itemId;
- (void)didSelectSelect:(NSInteger)itemId;
@end


@interface TEBuildingsListTextualCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *buildingName;
@property (nonatomic, strong) IBOutlet UILabel *buildingAddress;
@property (nonatomic, strong) IBOutlet UIButton *editButton;
@property (nonatomic, strong) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) IBOutlet UIButton *selectButton;
@property (nonatomic, strong) IBOutlet UIButton *viewDetailsButton;
@property (nonatomic, weak) id <TEBuildingsListTextualCellDelegate> delegate;
@property (nonatomic) NSInteger itemId;

- (IBAction)buttonPressed:(id)sender;

@end
