//
//  UIPickerViewWithDataSourceProperty.h
//  Приложение для кондитера
//
//  Created by Константин on 25.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIPickerViewWithDataSourceProperty : UIPickerView{
    BOOL showChild;
    
}

@property (nonatomic,copy) NSMutableArray *source_array;
@property (nonatomic,copy) NSMutableArray *child_array;
@property (nonatomic,copy) NSString *name;

- (instancetype) initWithDataArray:(NSMutableArray*) dataArray;


@end

NS_ASSUME_NONNULL_END
