//
//  DeliveryTime.h
//  Приложение для кондитера
//
//  Created by Игорь on 24.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryTime : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSMutableArray *deliveryTimesCertain;
@property (nonatomic, assign, getter=isHasDeliveryTimesCertain) BOOL HasDeliveryTimesCertain;

@end

NS_ASSUME_NONNULL_END
