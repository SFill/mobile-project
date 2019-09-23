//
//  SearchViewController.m
//  Приложение для кондитера
//
//  Created by Admin on 14.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableData = [@[@"Лавка кулинара",@"Кондитерский инвентарь"] mutableCopy];
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.tableData count]];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResults = [NSMutableArray arrayWithArray: [self.tableData filteredArrayUsingPredicate:resultPredicate]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
//
//    return YES;
//}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        return [self.searchResults count];
//    }
//    else
//    {
//        return [self.tableData count];
//    }
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
//    }
//    else
//    {
//        cell.textLabel.text = self.tableData[indexPath.row];
//    }
//    
//    return cell;
//}


@end




