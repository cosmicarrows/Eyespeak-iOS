//
//  TENotesViewerViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/23/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TENotesViewerViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface TENotesViewerViewController ()

@end

@implementation TENotesViewerViewController

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

- (void)updateUI
{
    self.noteTextView.text = self.noteText;
}


- (void)setNoteText:(NSString *)_noteText
{
    noteText = _noteText;
    [self updateUI];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
    DDLogVerbose (@"noteTextView.fram.origin.x %f", self.noteTextView.frame.origin.x);
    DDLogVerbose (@"noteTextView.fram.origin.y %f", self.noteTextView.frame.origin.y);
    DDLogVerbose (@"noteTextView.fram.size.width %f", self.noteTextView.frame.size.width);
    DDLogVerbose (@"noteTextView.fram.size.hieght %f", self.noteTextView.frame.size.height);
    DDLogVerbose (@"keyboardSize.height %f", keyboardSize.width);


    self.noteTextView.frame = CGRectMake(self.noteTextView.frame.origin.x, self.noteTextView.frame.origin.y, self.noteTextView.frame.size.width, self.noteTextView.frame.size.height - keyboardSize.width);
    
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.noteTextView.frame = CGRectMake(self.noteTextView.frame.origin.x, self.noteTextView.frame.origin.y, self.noteTextView.frame.size.width, self.noteTextView.frame.size.height + keyboardSize.width);
    
}

- (void) resetKeyboard
{
    [self.noteTextView resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self.noteTextView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.noteTextView layer] setBackgroundColor:[[UIColor whiteColor] CGColor]];
    [[self.noteTextView layer] setBorderWidth:1.5];
    [[self.noteTextView layer] setCornerRadius:5];
    [self.noteTextView setClipsToBounds: YES];
    
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

