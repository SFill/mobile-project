//
//  DeliveryMapViewController.h
//  nevkusno
//
//  Created by Никита  on 23.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "MapKit/MapKit.h"
#import "VMLocationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *deliveryMap;
@property (nonatomic) IBOutlet WKWebView *webView;
@property (retain,nonatomic) VMLocationManager *locationManager;
@end

NS_ASSUME_NONNULL_END
