//
//  DeliveryRussiaViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 06.06.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DeliveryRussiaViewController.h"

@interface DeliveryRussiaViewController ()

@end

@implementation DeliveryRussiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width, _scrollView.bounds.size.height*1.2)];
    // Do any additional setup after loading the view.
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
