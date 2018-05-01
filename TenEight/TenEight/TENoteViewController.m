//
//  TENoteViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/11/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TENoteViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface TENoteViewController ()

@end

@implementation TENoteViewController

@synthesize noteTextView;
@synthesize noteText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)donePressed
{
    [self.delegate noteUpdated:self.noteTextView.text];
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)cancelPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateUI
{
    self.noteTextView.text = self.noteText;
}


- (void)keyboardWasShown:(NSNotification *)notification
{
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.noteTextView.frame = CGRectMake(self.noteTextView.frame.origin.x, self.noteTextView.frame.origin.y, self.noteTextView.frame.size.width, self.noteTextView.frame.size.height - keyboardSize.height);

}

- (void) keyboardWillHide:(NSNotification *)notification {
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.noteTextView.frame = CGRectMake(self.noteTextView.frame.origin.x, self.noteTextView.frame.origin.y, self.noteTextView.frame.size.width, self.noteTextView.frame.size.height + keyboardSize.height);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self changeToiPhoneBaseBarItemsWithSwitchUser];
    }
    

    [[self.noteTextView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.noteTextView layer] setBackgroundColor:[[UIColor whiteColor] CGColor]];
    [[self.noteTextView layer] setBorderWidth:1.5];
    [[self.noteTextView layer] setCornerRadius:5];
    [self.noteTextView setClipsToBounds: YES];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                   style:UIBarButtonItemStyleBordered target:self action:@selector(donePressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [self updateUI];

}



- (void)viewDidUnload
{
    [super viewDidUnload];

    self.noteText = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
    else
    {
        return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
                (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end
