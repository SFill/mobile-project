//
//  MainPageViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 12.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainPageViewController : ViewController<UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate>{
        IBOutlet UIImageView *imgView;
}

@property(strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UICollectionView *Collection_view;
@property (strong, nonatomic) IBOutlet UICollectionView *сollection_view;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableViewSearch;
@property (strong, nonatomic) IBOutlet    NSMutableArray *filteredProcuts;
@property (weak, nonatomic) IBOutlet UIButton *salebutton;
@property (weak, nonatomic) IBOutlet UIButton *newbutton;
@property (weak, nonatomic) IBOutlet UIButton *lavka;
@property (weak, nonatomic) IBOutlet UIButton *shadowbutton;
@property (weak, nonatomic) IBOutlet UIButton *shadowbutton2;
@property (weak, nonatomic) IBOutlet UIButton *shadowbutton3;
@property (weak, nonatomic) IBOutlet UIButton *shadowbutton4;
@property (weak, nonatomic) IBOutlet UIButton *shadowbutton5;
@property (weak, nonatomic) IBOutlet UIButton *shadowbutton6;
@property (weak, nonatomic) IBOutlet UIButton *konditerskiyInventar;
@property (weak, nonatomic) IBOutlet UIButton *wholeSale;
@property (strong, atomic)  NSMutableDictionary *buttonTagDict;
@property (strong, atomic)  NSMutableArray *dataTransferArray;
@property (strong, atomic)  NSMutableArray *lastProducts;
@property (strong, atomic)  NSMutableArray *topProducts;
@property (strong, atomic)  NSMutableArray *wholeSaleProducts;
@property (strong, atomic)  NSNumber *pagesTopProducts;
@property (strong, atomic)  NSNumber *pageTopProducts;
@property (strong, atomic)  NSNumber *pagesLastProducts;
@property (strong, atomic)  NSNumber *pageLastProducts;
@property (strong, atomic)  NSNumber *pagesWholeSaleProducts;
@property (strong, atomic)  NSNumber *pageWholeSaleProducts;
@property (weak, nonatomic) IBOutlet UICollectionView *lastProductsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *topProductsCollectionView;


@end

NS_ASSUME_NONNULL_END
