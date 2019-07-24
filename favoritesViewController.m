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
    [self showSpinner:self.view];
    dispatch_group_t group =dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        [ApplicationData getFavorItems:@1 inPage:@50 OnSuccess:^(NSDictionary *data) {
            self.favorites = [[NSMutableArray alloc] init]; // todo добавить избранное в единый стораж
            [self.favorites addObjectsFromArray:[ApplicationData getProductsFromDict:data]];
             dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self removeSpinner];
        
    });
   // [self.tableView reloadData];
    // Do any additional setup after loading the view.
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
