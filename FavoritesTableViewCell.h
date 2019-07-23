//
//  FavoritesTableViewCell.h
//  Приложение для кондитера
//
//  Created by Константин on 23.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "catalog-app/Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesTableViewCell : UITableViewCell {
    Product *p;
}
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;


@end

NS_ASSUME_NONNULL_END
