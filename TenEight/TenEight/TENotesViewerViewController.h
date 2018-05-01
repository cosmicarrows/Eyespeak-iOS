//
//  TENotesViewerViewController.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TENotesViewerViewController : TEBaseViewController

@property (nonatomic, weak) IBOutlet UITextView *noteTextView;

@property (nonatomic, copy) NSString *noteText;

-(void) resetKeyboard;

@end
