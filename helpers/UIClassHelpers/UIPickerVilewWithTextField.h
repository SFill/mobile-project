//
//  UIPickerVilewWithTextField.h
//  nevkusno
//
//  Created by Никита  on 28.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIPickerVilewWithTextField : UIPickerView <UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak,nonatomic) UITextField *textField;
@property NSArray *dataSorceArray;
-(instancetype) initWithTextField: (UITextField*) textField andDataSource:(NSArray*)
dataSource;
@end

NS_ASSUME_NONNULL_END
