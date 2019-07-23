//
//  UserSettingsViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 16.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserSettingsViewController : UIViewController

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *pushMessagesButton;

@end

NS_ASSUME_NONNULL_END
