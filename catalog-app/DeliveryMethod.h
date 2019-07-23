//
//  DeliveryMethod.h
//  Приложение для кондитера
//
//  Created by Игорь on 24.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryMethod : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *methodDescription;
@property (nonatomic, assign, getter=isHasDeliveryTimes) BOOL HasDeliveryTimes;
@property (nonatomic, copy) NSMutableArray *deliveryTimes;

@end

NS_ASSUME_NONNULL_END
