//
//  VMCreateOrderObject.h
//  nevkusno
//
//  Created by Никита  on 28.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMCreateOrderObject : NSObject

@property NSMutableArray *items;
@property NSString *deliveryDate;
@property NSString *deliveryType;
@property NSString *deliveryTime;
@property NSString *deliveryDistance;
@property NSString *deliveryPrice;
@property NSString *deliveryUnderground;
@property NSString *deliveryPickPointAddress;
@property NSString *deliveryCdekInfo;
@property NSString *deliveryCdekAddress;
@property NSString *userDescription;

@property NSString *userName;
@property NSString *userLastName;
@property NSString *userPhone;
@property NSString *userCity;
@property NSString *userIndex;
@property NSString *userAddress;
@property NSString *addressRoom;

-(NSDictionary*) toDict;

@end

NS_ASSUME_NONNULL_END
