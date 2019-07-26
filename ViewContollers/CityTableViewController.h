//
//  CityTableViewController.h
//  nevkusno
//
//  Created by Никита  on 25.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../PickPointApi/PickPointCity.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *lettersCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *cityTable;
@property NSMutableArray *sections;
@property NSMutableArray *firstCityNameLetters;
@property (nonatomic, copy) void (^calbackBlock)(PickPointCity*);
@end

NS_ASSUME_NONNULL_END
