//
//  GNTableViewCell.h
//  Приложение для кондитера
//
//  Created by Игорь on 30.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GNTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textLabelDescription;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet UILabel *telText;
@property (weak, nonatomic) IBOutlet UILabel *workTimeText;
@property (weak, nonatomic) IBOutlet UITextView *priceText;

@end

NS_ASSUME_NONNULL_END
