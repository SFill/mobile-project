//
//  InventoryViewController.h
//  Приложение для кондитера
//
//  Created by Admin on 13.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource> {
    IBOutlet UIImageView *imgView;
}

@property(strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UICollectionView *Collection_view;
@property (strong, nonatomic) IBOutlet UICollectionView *сollection_view;


@end
