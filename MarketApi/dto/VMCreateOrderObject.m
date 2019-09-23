//
//  VMCreateOrderObject.m
//  nevkusno
//
//  Created by Никита  on 28.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "VMCreateOrderObject.h"

@implementation VMCreateOrderObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.deliveryPickPointAddress =@"";
        self.deliveryDate =@"";
        self.deliveryType =@"";
        self.deliveryPrice =@"";
        self.deliveryTime =@"";
        self.deliveryDistance =@"";
        self.deliveryUnderground =@"";
        self.deliveryCdekInfo =@"";
        self.deliveryCdekAddress =@"";
        self.userPhone =@"";
        self.userName =@"";
        self.userCity =@"";
        self.userIndex =@"";
        self.userAddress =@"";
        self.addressRoom =@"";
        self.userDescription=@"";
        self.userLastName=@"";
    }
    return self;
}

-(NSDictionary*) toDict{
//    NSMutableDictionary *dictionary = [NSMutableDictionary new];
//    [dictionary setObject:self.items forKey:@"items"];
//    [dictionary setObject:self.deliveryDate forKey:@"deliveryDate"];
//    [dictionary setObject:self.deliveryType forKey:@"deliveryType"];
//    [dictionary setObject:self.deliveryPrice forKey:@"deliveryPrice"];
//    [dictionary setObject:self.deliveryTime forKey:@"deliveryTime"];
//    [dictionary setObject:self.deliveryDistance forKey:@"deliveryDistance"];
//    [dictionary setObject:self.deliveryUnderground forKey:@"deliveryUnderground"];
//    [dictionary setObject:self.deliveryPickPointAddress forKey:@"deliveryPickPointAddress"];
//    [dictionary setObject:self.deliveryCdekInfo forKey:@"deliveryCdekInfo"];
//
//
//     [dictionary setObject:self.deliveryCdekAddress forKey:@"deliveryCdekAddress"];
//     [dictionary setObject:self.userName forKey:@"userName"];
//     [dictionary setObject:self.userCity forKey:@"userCity"];
//     [dictionary setObject:self.userIndex forKey:@"userIndex"];
//    [dictionary setObject:self.userAddress forKey:@"userAddress"];
//    [dictionary setObject:self.userRegion forKey:@"userRegion"];
//
//    return dictionary;
    return @{
             @"items":self.items,
             @"deliveryDate":self.deliveryDate,
             @"deliveryType":self.deliveryType,
             @"deliveryPrice":self.deliveryPrice,


             @"deliveryTime":self.deliveryTime,
             @"deliveryDistance":self.deliveryDistance,
             @"deliveryUnderground":self.deliveryUnderground,
             @"deliveryPickPointAddress":self.deliveryPickPointAddress,

             @"deliveryCdekInfo":self.deliveryCdekInfo,

             @"deliveryCdekAddress":self.deliveryCdekAddress,
             @"userName":self.userName,
             @"userLastName":self.userLastName,

             @"userPhone":self.userPhone,
             @"userCity":self.userCity,
             @"userIndex":self.userIndex,
             @"userAddress":self.userAddress,
             @"addressRoom":self.addressRoom,
             };
}

@end
