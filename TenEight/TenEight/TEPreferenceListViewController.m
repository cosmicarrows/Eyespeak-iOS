//
//  TEPreferenceListViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 9/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEPreferenceListViewController.h"

@interface TEPreferenceListViewController ()

@end

@implementation TEPreferenceListViewController


@synthesize preferencesTable;
@synthesize preferences=_preferences;
@synthesize delegate;


- (void)setPreferences:(NSArray *)preferences
{
    _preferences = preferences;
    [self.preferencesTable reloadData];
}

- (void)didUpdateAttribute:(int)attributeID withValue:(NSString *)value
{
    [self.delegate didUpdateAttribute:attributeID withValue:value ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.preferences count];
}

- (void)configureIPhoneCell:(TEPreferencesIPhoneCell *)cell withAttribute:(TEAttribute *)item
{
    cell.delegate = self;
    cell.title.text = item.name;
    cell.secondary.text = item.desc;
    cell.attributeID = [item.attributeID intValue];
    cell.value = item.value;
    [cell.button1 setTitle:@"L" forState:UIControlStateNormal];
    [cell.button2 setTitle:@"M" forState:UIControlStateNormal];
    [cell.button3 setTitle:@"H" forState:UIControlStateNormal];
    [cell.button1 setTitle:@"L" forState:UIControlStateSelected];
    [cell.button2 setTitle:@"M" forState:UIControlStateSelected];
    [cell.button3 setTitle:@"H" forState:UIControlStateSelected];
    [cell.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [cell.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [cell.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

- (void)configureIPadCell:(TEPreferencesIPadCell *)cell withAttribute:(TEAttribute *)item
{
    cell.delegate = self;
    cell.title.text = item.name;
    cell.secondary.text = item.desc;
    cell.attributeID = [item.attributeID intValue];
    cell.value = item.value;
    [cell.button1 setTitle:@"L" forState:UIControlStateNormal];
    [cell.button2 setTitle:@"M" forState:UIControlStateNormal];
    [cell.button3 setTitle:@"H" forState:UIControlStateNormal];
    [cell.button1 setTitle:@"L" forState:UIControlStateSelected];
    [cell.button2 setTitle:@"M" forState:UIControlStateSelected];
    [cell.button3 setTitle:@"H" forState:UIControlStateSelected];
    [cell.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [cell.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [cell.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TEAttribute *item = [self.preferences objectAtIndex:indexPath.row];
    
    UITableViewCell *cell;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"iPhonePreferencesCell"];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TEPreferencesIPhoneCell" owner:nil options:nil];
            
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (TEPreferencesIPhoneCell *)currentObject;
                    break;
                }
            }
        }
        [self configureIPhoneCell: (TEPreferencesIPhoneCell *)cell withAttribute:item];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"iPadPreferencesCell"];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TEPreferencesIPadCell" owner:nil options:nil];
            
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (TEPreferencesIPadCell *)currentObject;
                    break;
                }
            }
        }
        [self configureIPadCell: (TEPreferencesIPadCell *)cell withAttribute:item];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 77;
        
    } else {
        return 93;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSString *errordesc = [((NSError *)error) localizedDescription];
    if ([error code]==4) {
        errordesc  = @"Network error.  The connection was blocked (you may need to first log in to the wireless network) or the server has failed to respond.";
    }

    [self provideMessage:errordesc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end
