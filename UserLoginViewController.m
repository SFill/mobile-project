//
//  UserLoginViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 11.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UIViewController+UIViewContollerWithSpinnerCategory.h"
#import "catalog-app/ApplicationData.h"
@interface UserLoginViewController ()<UITextFieldDelegate>

@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginText.delegate = self;
    self.passwordText.delegate = self;
    // Do any additional setup after loading the view.
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginUser:(id)sender {
    [self showSpinner:self.view];
    NSString *login = _loginText.text;
    NSString *password = _passwordText.text;
    [ApplicationData login:login withPassword:password
                 onSuccess:^(NSDictionary* data)  {
                     [self performSegueWithIdentifier:@"toStartPage" sender:sender];
                     [self removeSpinner];
                     
                 }
                 onFailure:^(NSString* message){
                     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {
                                                                               [self removeSpinner];
                                                                           }];
                     [alert addAction:defaultAction];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
     ];
    
    
}

- (IBAction)registrUser:(id)sender {
    [self showSpinner:self.view];
    NSString *login = _loginText.text;
    NSString *password = _passwordText.text;
    [ApplicationData registr:login withPassword:password
                 onSuccess:^(NSDictionary* data)  {
                     [self performSegueWithIdentifier:@"toStartPage" sender:sender];
                     [self removeSpinner];
                     
                 }
                 onFailure:^(NSString* message){
                     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {
                                                                               [self removeSpinner];
                                                                           }];
                     [alert addAction:defaultAction];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
     ];
}

@end