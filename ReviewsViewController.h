//
//  ReviewsViewComtollersViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 15.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewsViewController : UIViewController
@property (nonatomic) NSMutableArray *reviews;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@end

NS_ASSUME_NONNULL_END
