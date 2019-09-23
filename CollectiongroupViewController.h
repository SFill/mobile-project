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
@property (strong, nonatomic) VMCategory *selectedCategory;
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *products;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *сollection_view;
@property (strong, atomic)  NSMutableArray *dataTransferArray;
@property (strong, atomic)  NSNumber *pages;
@property (strong, atomic)  NSNumber *pagesLastProducts;
@property (strong, atomic)  NSMutableArray *lastProducts;
@property  NSMutableArray *filteredCategories;
@property  NSString *searchText;

@end
