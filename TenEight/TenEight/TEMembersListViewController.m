//
//  TEMembersListViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/14/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEMembersListViewController.h"
#import "TEMembersListIPadCell.h"
#import "TEMembersListIPhoneCell.h"

@interface TEMembersListViewController ()

@end


@implementation TEMembersListViewController

@synthesize memberTableView;
@synthesize currentTourID;
@synthesize activityIndicator;
@synthesize membersProxy;
@synthesize members;



- (BOOL)toggleEditMode {
    
    if ([self.memberTableView isEditing]) {
        [self.memberTableView setEditing:NO animated:YES];
        return NO;
    }
    else {
        [self.memberTableView setEditing:YES animated:YES];
        return YES;
    }
}


- (void)loadMembersInTour:(NSInteger)tourID
{
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
    }

    self.currentTourID = tourID;
    [self.membersProxy loadMembersInTour:self.currentTourID];
}


- (void)deleteMember:(NSInteger)row
{
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
    }
    
    [self.membersProxy deleteMember:((TETourMember *)[self.members objectAtIndex:row]).userId
                                    fromTour:self.currentTourID];
}

- (void)deletePressed:(NSString *)dbid
{ // user pressed delete button in the cell
    if([[[RKClient sharedClient]reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]){
        [self.activityIndicator startAnimating];
    }
    
    [self.membersProxy deleteMember:dbid fromTour:self.currentTourID];
    
}


#pragma mark TEMembersDelegate methods

- (void)membersLoaded:(BOOL)success withMessage:(NSString *)message
{
    [self.activityIndicator stopAnimating];
    if (success) {
        NSError* error;
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"TETourMember" inManagedObjectContext:[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread];
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tourId = %d", self.currentTourID];
        [fetchRequest setPredicate:predicate];
        
        self.members = [[RKObjectManager sharedManager].objectStore.managedObjectContextForCurrentThread executeFetchRequest:fetchRequest error:&error];

        [self.memberTableView reloadData];
    } else {
        [self provideMessage:message];
    }
}

- (void)memberDeleted:(BOOL)success withMessage:(NSString *)message
{
    [self.activityIndicator stopAnimating];
    if (success) {
        [self provideMessage:@"Member removed from tour."];
        [self loadMembersInTour:self.currentTourID];
    } else {
        [self provideMessage:message];
    }
}


#pragma mark UITableViewDelegate methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.members count];
}

- (void)configureIPadCell:(TEMembersListIPadCell *)cell withMemberInfo:(TETourMember *)item
{
    if (!theAppDelegate().switchUserMode && (theAppDelegate().masterUserType==TEUserPro)) {
        cell.deleteButton.hidden = NO;
    } else {
        cell.deleteButton.hidden = YES;
    }
    cell.memberID.text = item.email;
    cell.dbid = item.userId;
    cell.delegate = self;
}

- (void)configureIPhoneCell:(TEMembersListIPhoneCell *)cell withMemberInfo:(TETourMember *)item
{
    cell.memberID.text = item.email;
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!theAppDelegate().switchUserMode && (theAppDelegate().masterUserType==TEUserPro)) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = [indexPath row];
        [self deleteMember:row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TETourMember *item = [self.members objectAtIndex:indexPath.row];
    

    UITableViewCell *cell;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"iPhoneMembersCell"];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TEMembersListIPhoneCell" owner:nil options:nil];
            
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (TEMembersListIPhoneCell *)currentObject;
                    break;
                }
            }
        }
        
        [self configureIPhoneCell:(TEMembersListIPhoneCell *)cell withMemberInfo:item];

    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"iPadMembersCell"];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TEMembersListIPadCell" owner:nil options:nil];
            
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (TEMembersListIPadCell *)currentObject;
                    break;
                }
            }
        }
        
        [self configureIPadCell:(TEMembersListIPadCell *)cell withMemberInfo:item];
    }
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark Controller Management methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.membersProxy = [[TEMembersProxy alloc] init];
        self.membersProxy.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSString *errordesc = [((NSError *)error) localizedDescription];
    if ([error code]==4) {
        errordesc  = @"Network error.  The connection was blocked (you may need to first log in to the wireless network) or the server has failed to respond.";
    }

    [self provideMessage:errordesc];
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
    [super viewDidUnload];
    
    self.membersProxy = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end
