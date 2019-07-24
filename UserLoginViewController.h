//
//  UserLoginViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 11.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserLoginViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (retain, nonatomic)  NSString *message;

@end

NS_ASSUME_NONNULL_END
