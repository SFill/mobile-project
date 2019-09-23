//
//  VMLocationManager.m
//  nevkusno
//
//  Created by Никита  on 23.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "VMLocationManager.h"

@implementation VMLocationManager

-(NSString*) getGelocationStatus{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusDenied:
            //[self.locationButton setTitle: forState:UIControlStateNormal];
            return @"Геолокация запрещена";
            break;
        case kCLAuthorizationStatusNotDetermined:
            //[self.geoSwitch setOn:NO];
            
            return @"Разрешение не запрашивалось";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return @"Геолокация разрешена";
            //[self.geoSwitch setOn:YES];
            //            [self.locationButton setTitle: forState:UIControlStateNormal];
            break;
        default:
            break;
            
    }
    return @"Не известно";
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations objectAtIndex:0];
    [self stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       //CLPlacemark *placemark = [placemarks objectAtIndex:0];
                   }];
}

@end
