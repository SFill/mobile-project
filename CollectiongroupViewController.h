//
//  CollectiongroupViewController.h
//  Приложение для кондитера
//
//  Created by User on 17/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "catalog-app/VMCategory.h"


@interface CollectiongroupViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource> {
    IBOutlet UIImageView *imgView;
}

@property(strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UICollectionView *Collection_view;
@property (strong, nonatomic) IBOutlet VMCategory *selectedCategory;
@property (strong, nonatomic) IBOutlet NSMutableArray *categories;
@property (strong, nonatomic) IBOutlet NSMutableArray *products;
@property (strong, nonatomic) IBOutlet UICollectionView *сollection_view;
@property (strong, atomic) IBOutlet NSMutableArray *dataTransferArray;
@property (strong, atomic)  NSNumber *pages;
@property (strong, atomic)  NSNumber *pagesLastProducts;
@property (strong, atomic)  NSMutableArray *lastProducts;

@end
