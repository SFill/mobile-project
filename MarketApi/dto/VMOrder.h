//
//  VMOrder.h
//  nevkusno
//
//  Created by Никита  on 29.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMOrder : NSObject
@property NSString *userName;
@property NSString *userLastName;
@property NSString *userAddress;
@property NSString *userIndex;
@property NSString *userRoom;
@property NSString *deliveryDate;
@property NSString *phoneNumber;
@property NSNumber *goodsPrice;
@end

NS_ASSUME_NONNULL_END
