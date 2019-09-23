//
//  UserSettingsViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 16.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "catalog-app/ApplicationData.h"


@interface UserSettingsViewController ()<CLLocationManagerDelegate>

@end

@implementation UserSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *permittedStatus = @"Геолокация разрешена";
    
    
    NSString *geoStatus = [ApplicationData getGelocationStatus];
    [self.locationButton setTitle:geoStatus forState:UIControlStateNormal];
    
    if (![permittedStatus isEqualToString:geoStatus]) {
        [self.locationButton setTitle:@"Нажмите для определения" forState:UIControlStateNormal];
        return;
    }
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate =self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager startUpdatingLocation];
   
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations objectAtIndex:0];
    [self.locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       NSString *city = [placemark locality];
                       [self.cityNameLabel setText:city];
                   }];
}

- (IBAction)switchLocationPermision:(id)sender {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusNotDetermined:
            [self changeLocationPermision];
            break;
        default:
            break;
    }
}

-(void) changeLocationPermision{
    NSString *message =@"Для определения вашего города необходимо разрешить геолокацию для приложения в настройках";
    [self showActionViewWithMessage:message];
    
   
}
- (IBAction)changePushMessagesPermision:(id)sender {
    NSString *message =@"Если вы хотие получать push уведомеления о новых поступлениях и обновлениях товара, разрешите их в настройках";
    [self showActionViewWithMessage:message];
    
}


-(void) showActionViewWithMessage:(NSString*) message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Разрешить доступ" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Разрешить" style:UIAlertActionStyleCancel                                                          handler:^(UIAlertAction * action) {
        NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            NSLog(@"Done");
        }];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleDefault                                                         handler:^(UIAlertAction * action) {
        
    }];
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
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
