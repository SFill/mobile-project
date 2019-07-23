//
//  ReviewsViewComtollersViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 15.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ReviewsViewController.h"

@interface ReviewsViewController ()

@end

@implementation ReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tabelView setRowHeight:85];
    
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *simpleTableIdentifier = @"FavoritesTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell"];
    NSDictionary *review = [self.reviews objectAtIndex:indexPath.row];
    UILabel  *clientName = [cell viewWithTag:1];
    UILabel  *rate = [cell viewWithTag:2];
    [clientName setText:[review objectForKey:@"NAME"]];
    NSString *star = @"★";
    NSMutableString *rateStartString = [[NSMutableString alloc]init];
    int end =[[review objectForKey:@"RATING"] intValue];
    for (int i=0; i<end; i++) {
        [rateStartString appendString:star];
    }
    [rate setText:rateStartString];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.reviews count];
    //return [self.reviews count];
    
    
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
