//
//  GNDropTableViewCell.h
//  Приложение для кондитера
//
//  Created by Игорь on 05.06.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GNDropTableViewCell : UITableViewCell{
    NSMutableArray *data;
    NSMutableArray *dataDescription;
    NSInteger expandedRowIndex;
}
@property (weak, nonatomic) IBOutlet UITextView *addressText;
@property (weak, nonatomic) IBOutlet UITextView *priceText;
@property (weak, nonatomic) IBOutlet UILabel *telText;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;



@end

NS_ASSUME_NONNULL_END
