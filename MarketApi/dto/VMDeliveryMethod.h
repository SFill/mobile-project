//
//  DeliveryMethod.h
//  nevkusno
//
//  Created by Никита  on 26.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *VMDeliveryMethodPriceMultiple = @"MULTIPLE" ;
static NSString *VMDeliveryMethodPriceSingle = @"SINGLE";

NS_ASSUME_NONNULL_BEGIN

@interface VMDeliveryMethod : NSObject
@property (nonatomic,retain) NSNumber *Id;
@property (nonatomic,retain) NSNumber *code;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *itemDescription;
@property (nonatomic,retain) NSString *currency;
@property (nonatomic,retain) NSNumber *price;
@property (nonatomic,retain) NSMutableArray *priceRanges;
@property (nonatomic,retain) NSString *priceType;
@end
NS_ASSUME_NONNULL_END
