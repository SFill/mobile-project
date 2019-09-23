//
//  EndViewController.m
//  Приложение для кондитера
//
//  Created by User on 26/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "EndViewController.h"

@interface EndViewController ()

@end

@implementation EndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _returnbutton.layer.cornerRadius =10;
    self.textField.text = self.text;
    // Do any additional setup after loading the view.
}
- (IBAction)returnToMainScreen:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
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
