//
//  DetailTextDeliveryVCViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 06.06.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DetailTextDeliveryVCViewController.h"

@interface DetailTextDeliveryVCViewController ()

@end

@implementation DetailTextDeliveryVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _deliveryText.text = _deliveryTextIntent;
    _advantagesText.text = _advantagesTextIntent;
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
