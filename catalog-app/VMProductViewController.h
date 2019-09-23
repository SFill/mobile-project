//
//  ViewController.h
//  Приложение для кондитера
//
//  Created by Игорь on 26/12/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "VMCategory.h"


@interface VMProductViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
typedef void (^ SuccessBlock)(NSDictionary*);
typedef void (^ FailedBlock)(NSString*);
@property (strong, nonatomic) IBOutlet UICollectionView *Collection_view;

@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) VMCategory *category;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *filteredProducts;
@property (strong, atomic)  NSNumber *pages;
@property (strong, atomic)  NSNumber *pageNum;
@property (strong, atomic)  NSString *searchText;
@property (nonatomic, copy) void (^updateBlock)(NSNumber *page, SuccessBlock success,FailedBlock failed);
@end


