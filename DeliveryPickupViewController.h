//
//  DeliveryPickupViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 06.06.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface DeliveryPickupViewController : ViewController{
    NSMutableArray *data;
    NSMutableArray *dataDescription;
    NSMutableArray *dataPrice;
    NSMutableArray *dataAddres;
    NSMutableArray *dataTel;
    NSMutableArray *dataWorkTime;
    NSInteger expandedRowIndex;
}

@end

NS_ASSUME_NONNULL_END
