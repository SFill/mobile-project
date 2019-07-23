//
//  PickerView.h
//  Приложение для кондитера
//
//  Created by Игорь on 21.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickerView : UIPickerView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@end

NS_ASSUME_NONNULL_END
