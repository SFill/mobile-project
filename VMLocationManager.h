//
//  VMLocationManager.h
//  nevkusno
//
//  Created by Никита  on 23.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MapKit/MapKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMLocationManager : CLLocationManager
-(NSString*) getGelocationStatus;
@end

NS_ASSUME_NONNULL_END
