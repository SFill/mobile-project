//
//  SaleViewController.h
//  Приложение для кондитера
//
//  Created by User on 07/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SaleViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource> {
    IBOutlet UIImageView *imgView;
}

@property (strong, nonatomic) IBOutlet UICollectionView *Collection_view;


@end


