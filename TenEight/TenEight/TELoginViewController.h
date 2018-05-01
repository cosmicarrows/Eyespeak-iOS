//
//  TEViewController.h
//  TenEight
//
//  Created by Kennedy Kok on 8/8/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TELoginViewController : TEBaseViewController <RKObjectLoaderDelegate, TEBaseDelegate, UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField* emailAddressTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton* loginButton;
@property (nonatomic, weak) IBOutlet UISegmentedControl* userSwitch;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollBack;

@property (nonatomic, strong) TELogin* loginObj;
@property (nonatomic) NSInteger userType;

- (IBAction)login:(id)sender;
- (IBAction)userCreateAccount:(id)sender;
- (IBAction)changeLoginType:(id)sender;

@end

