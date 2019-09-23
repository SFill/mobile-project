//
//  Product.h
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *ves;
@property (nonatomic, copy) NSString *stars;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pDescription;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *price2;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *article;
@property (nonatomic, strong) NSString *searchbar;
@property (nonatomic, copy) NSString *imageName2;
@property (nonatomic, copy) NSNumber *amount; // для корзины
@property (nonatomic, copy) NSNumber *stocks_quantity; // склады
@property (nonatomic, copy) NSNumber *itemId;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic) BOOL inCart;
@property (nonatomic) BOOL inFav;
@property (nonatomic) UIImage *previewImg;
@property (nonatomic) UIImage *detailImg;
@property (nonatomic) NSString *previewImgStringURL;
@property (nonatomic) NSString *detailImgStringURL;

@property (nonatomic) NSMutableArray *reviews;
-(NSDictionary*) getDataForOrderCreateObject;


@end
