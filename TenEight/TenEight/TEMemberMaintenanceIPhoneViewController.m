//
//  TEMemberMaintenanceIPhoneViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/20/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEMemberMaintenanceIPhoneViewController.h"

@interface TEMemberMaintenanceIPhoneViewController ()

@end

@implementation TEMemberMaintenanceIPhoneViewController

@synthesize memberAddressField;
@synthesize addMemberButton;
@synthesize membersArea;
@synthesize activityIndicator;
@synthesize membersController;
@synthesize tourID;
@synthesize editButton;
@synthesize tourProxy;


#pragma mark TETourDelegate methods

-(void)memberAddedToTour:(BOOL)success withMessage:(NSString *)message
{
    [self.activityIndicator stopAnimating];
    
    if (success) {
        [self provideMessage:@"Member added successfully."];
        [self.membersController loadMembersInTour:self.tourID];
        self.memberAddressField.text = @"";
    } else {
        [self provideMessage:message];
    }
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tourProxy = [[TETourProxy alloc] init];
    [self.tourProxy setDelegate:self];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"button_black"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"button_black_highlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageDisabled = [[UIImage imageNamed:@"button_black_disabled"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [self.addMemberButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.addMemberButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [self.addMemberButton setBackgroundImage:buttonImageDisabled forState:UIControlStateDisabled];


    self.membersController = [[TEMembersListViewController alloc] init];
    
    [[self.membersArea subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.membersArea.frame.size.width, self.membersArea.frame.size.height) style:UITableViewStylePlain];

    table.dataSource = self.membersController;
    table.delegate = self.membersController;
    self.membersController.memberTableView = table;
    [self.membersArea addSubview:table];
    
    [self.membersController loadMembersInTour:self.tourID];

    editButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                  action:@selector(toggleEditMode:)];
    [self addBarButton:editButton];
    
}

- (void)toggleEditMode:(NSNotification *)notification {
    if ([self.membersController toggleEditMode]) {
        self.editButton.title = @"Done";
    } else {
        self.editButton.title = @"Edit";
    }
}


- (void)resignResponders
{
    [self.memberAddressField resignFirstResponder];
}

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignResponders];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self addMember:textField];
    return YES;
}


- (void)addMember:(id)sender
{
    
    NSString *memberName = [self.memberAddressField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *errors = @"";
    
    if (memberName.length == 0) {
        errors = [errors stringByAppendingString:@"Member Address must not be blank.\n"];
    }
    
    if (errors.length > 0) {
        [self provideMessage:errors];
    } else {
        if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
            [self.activityIndicator startAnimating];
        }
        [self.tourProxy addMember:memberName toTour:self.tourID];
    }
}


- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSString *errordesc = [((NSError *)error) localizedDescription];
    if ([error code]==4) {
        errordesc  = @"Network error.  The connection was blocked (you may need to first log in to the wireless network) or the server has failed to respond.";
    }

    [self provideMessage:errordesc];
    [self.activityIndicator stopAnimating];
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

- (void)viewDidUnload
{
    self.membersController = nil;
    self.editButton = nil;
    self.tourProxy = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end
