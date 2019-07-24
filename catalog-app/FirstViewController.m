//
//  FirstViewController.m
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "FirstViewController.h"
#import "ApplicationData.h"
#import "Product.h"
#import "VMPoductViewController.h"



@interface FirstViewController () <UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchApplicationData
{
    self.results = nil;
    
    NSPredicate *resoultsPredicate = [NSPredicate predicateWithFormat:@"SELF contains[p]%@",self.searchBar.text];
    self.results = [[self.objects filteredArrayUsingPredicate:resoultsPredicate] mutableCopy];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchApplicationData];
}

-(NSInteger)numberOfSectionInTableView:(UITableView *) tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [[ApplicationData getCatalog] count];
    }else{
        [self searchApplicationData];
        return self.results.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentyfier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentyfier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentyfier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (tableView == self.tableView){
        cell.textLabel.text = self.objects[indexPath.row];
    }else{
        cell.textLabel.text = self.results[indexPath.row];
    }
    
    Product *p = [[ApplicationData getCatalog] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = p.category;
    cell.imageView.image = [UIImage imageNamed:p.imageName2];
    cell.detailTextLabel.text = p.article;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    VMPoductViewController *vc = segue.destinationViewController;
    
    vc.product = [[ApplicationData getCatalog] objectAtIndex:self.tableView.
        indexPathForSelectedRow.row];
}



@end
