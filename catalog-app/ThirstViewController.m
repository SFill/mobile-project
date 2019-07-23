//
//  ThirstViewController.m
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "ThirstViewController.h"
#import "ApplicationData2.h"
#import "VMCategory.h"
#import "DetailsViewController.h"



@interface ThirstViewController () <UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ThirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchApplicationData2
{
    self.results = nil;
    
    NSPredicate *resoultsPredicate = [NSPredicate predicateWithFormat:@"SELF contains[p]%@",self.searchBar.text];
    self.results = [[self.objects filteredArrayUsingPredicate:resoultsPredicate] mutableCopy];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchApplicationData2];
}

-(NSInteger)numberOfSectionInTableView:(UITableView *) tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [[ApplicationData2 getCategory] count];
    }else{
        [self searchApplicationData2];
        return self.results.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentyfier = @"pell";
    UITableViewCell *pell = [tableView dequeueReusableCellWithIdentifier:CellIdentyfier];
    
    if (!pell) {
        pell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentyfier];
        pell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (tableView == self.tableView){
        pell.textLabel.text = self.objects[indexPath.row];
    }else{
        pell.textLabel.text = self.results[indexPath.row];
    }
    
    VMCategory *p = [[ApplicationData2 getCategory] objectAtIndex:indexPath.row];
    
    pell.textLabel.text = p.parentID;
    
    return pell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailsViewController *vc = segue.destinationViewController;
    
    vc.product = [[ApplicationData2 getCategory] objectAtIndex:self.tableView.
        indexPathForSelectedRow.row];
}



@end
