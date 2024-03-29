//
//  favoritesViewController.m
//  Приложение для кондитера
//
//  Created by Константин on 23.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "favoritesViewController.h"
#import "TableViewCell.h"
#import "catalog-app/ApplicationData.h"
#import "UIViewController+UIViewContollerWithSpinnerCategory.h"

@interface favoritesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation favoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favorites = [ApplicationData getFavorites];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath{
  //  [self.tableView reloadData];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FavoritesTableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FavoritesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
         //Product *p = [[ApplicationData getFavorites] objectAtIndex:indexPath.row];
        Product *p = [self.favorites objectAtIndex:indexPath.row];
         [cell setProduct:p];
    }

    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSInteger item =  [[ApplicationData getFavorites] count];
    //return item;
    return [self.favorites count];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
