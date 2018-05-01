//
//  TEMembersPopoverViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 10/5/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEMembersPopoverViewController.h"

@interface TEMembersPopoverViewController ()

@end

@implementation TEMembersPopoverViewController

@synthesize members;
@synthesize membersTable;

- (void)viewWillAppear:(BOOL)animated
{
    self.members = [theAppDelegate().switchUserController getSwitchMembers];
    [self.membersTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.members count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MemberPopoverCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.members objectAtIndex:indexPath.row];

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate memberSelected:[self.members objectAtIndex:indexPath.row]];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
