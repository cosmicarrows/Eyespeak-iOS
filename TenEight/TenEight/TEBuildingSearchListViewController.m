//
//  TEBuildingSearchListViewController.m
//  TenEight
//
//  Created by Brad Wiederholt on 10/3/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import "TEBuildingSearchListViewController.h"
#import "TEBuildingsListTextualCell.h"

@interface TEBuildingSearchListViewController ()

@end

@implementation TEBuildingSearchListViewController

@synthesize buildingTableView;
@synthesize activityIndicator;
@synthesize searchBuildings;
@synthesize cellType;

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


- (void)showSearchBuildings:(NSArray *)_searchBuildings
{
    self.searchBuildings = _searchBuildings;
    [self.buildingTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchBuildings count];
}



- (void)configureTextualCell:(TEBuildingsListTextualCell *)cell withBuildingInfo:(TEBuildingInfo *)item atIndex:(int)index
{
    
    cell.buildingName.text = item.name;
    cell.buildingAddress.text = item.address;
    cell.itemId = [item.buildingID intValue];
    cell.editButton.hidden = YES;
    cell.deleteButton.hidden = YES;
    cell.viewDetailsButton.hidden = YES;
    cell.selectButton.hidden = YES;
    cell.delegate = self;
    switch (self.cellType) {
        case CellTypeAdd:
            cell.selectButton.hidden = NO;
            break;
        case CellTypeView:
            cell.viewDetailsButton.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TextualCellIdentifier = @"TextualCell";
    
    TEBuildingInfo *item = [self.searchBuildings objectAtIndex:indexPath.row];
    
    UITableViewCell *cell;
    
    // cell from .xib, load this way
    cell = [tableView dequeueReusableCellWithIdentifier:TextualCellIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TEBuildingsListTextualCell" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (TEBuildingsListTextualCell *)currentObject;
                break;
            }
        }
    }
    [self configureTextualCell:(TEBuildingsListTextualCell *)cell withBuildingInfo:item atIndex:indexPath.row];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
// supress any actions, this list is using the buttons in order to perform actions
//    TEBuildingFromSearch *selectedBuilding = [self.searchBuildings objectAtIndex:indexPath.row];
//    [self didSelectSelect:[selectedBuilding.buildingID intValue]];
}

- (void)didSelectSelect:(NSInteger)itemId
{
    TEBuildingInfo *searchBuilding;
    for (searchBuilding in self.searchBuildings) {
        if ([searchBuilding.buildingID intValue] == itemId) {
            if ([self.delegate respondsToSelector:@selector(didSelectBuildingFromList:)]) {
                [self.delegate didSelectBuildingFromList:searchBuilding];
            }
        }
    }
}

- (void)didSelectView:(NSInteger)itemId
{
    // user pressed the view button on this cell, or selected it from list
    TEBuildingInfo *searchBuilding;
    for (searchBuilding in self.searchBuildings) {
        if ([searchBuilding.buildingID intValue] == itemId) {
            if ([self.delegate respondsToSelector:@selector(didSelectView:)]) {
                [self.delegate didSelectView:searchBuilding];
            }
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.searchBuildings = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (![self isViewLoaded]) {
    }
}

@end

