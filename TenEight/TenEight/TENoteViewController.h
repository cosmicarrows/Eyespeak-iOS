//
//  TENoteViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/11/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEBaseViewController.h"

@protocol TENoteViewControllerDelegate <NSObject>
-(void) noteUpdated:(NSString *) noteText;
@end

@interface TENoteViewController : TEBaseViewController

@property (nonatomic, weak) IBOutlet UITextView *noteTextView;

@property (nonatomic, copy) NSString *noteText;
@property (nonatomic, weak) id<TENoteViewControllerDelegate> delegate;

- (IBAction)donePressed;
- (IBAction)cancelPressed:(id)sender;

@end
