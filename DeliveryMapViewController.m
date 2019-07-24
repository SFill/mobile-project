//
//  DeliveryMapViewController.m
//  nevkusno
//
//  Created by Никита  on 23.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DeliveryMapViewController.h"

@interface DeliveryMapViewController ()<MKMapViewDelegate>

@end

@implementation DeliveryMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deliveryMap.delegate =self;
    //[self.locationManager startUpda
    CLLocation *location = [self.locationManager location];
    [self centerMapOnLocation:location];
    [self setAnnotaions:location];
    // Do any additional setup after loading the view.
}

-(void) centerMapOnLocation:(CLLocation*) location{
    CLLocationDistance locationDistance = 1000;
    MKCoordinateRegion rg =  MKCoordinateRegionMakeWithDistance(location.coordinate, locationDistance, locationDistance);
    [self.deliveryMap setRegion:rg];
    
}
-(void) setAnnotaions:(CLLocation*) location{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]  init];
    [annotation setCoordinate:location.coordinate];
    [annotation setTitle:@"Ты здесь"];
    [self.deliveryMap addAnnotation:annotation];
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
