//
//  TESortViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/17/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TESortViewController.h"

@interface TESortViewController ()

@end

@implementation TESortViewController

@synthesize sortOptionsTable;
@synthesize sortOrder = _sortOrder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setSortOrder:(int)sortOrder
{
    _sortOrder = sortOrder;
    //highlight the current order button
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)configureTextForCell:(UITableViewCell *)cell withIndex:(int)index
{
    if (index == self.sortOrder) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    if (index==0) {
        label.text = @"Most Recent";
    } else {
        label.text = @"Name";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sbTourSortItem"];
    [self configureTextForCell:cell withIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.sortOrder = indexPath.row;
    [self.sortOptionsTable reloadData];
    [self.delegate sortPressed:self.sortOrder];
    [self.delegate sortDone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
