//
//  DetailTextDeliveryVCViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 06.06.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailTextDeliveryVCViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextView *deliveryText;
@property (weak, nonatomic) IBOutlet UITextView *advantagesText;


@property (weak, nonatomic) IBOutlet NSString *deliveryTextIntent;
@property (weak, nonatomic) IBOutlet NSString *advantagesTextIntent;

@end

NS_ASSUME_NONNULL_END
