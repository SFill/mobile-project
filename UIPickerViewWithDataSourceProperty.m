//
//  UIPickerViewWithDataSourceProperty.m
//  Приложение для кондитера
//
//  Created by Константин on 25.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "UIPickerViewWithDataSourceProperty.h"

@implementation UIPickerViewWithDataSourceProperty



- (instancetype) initWithDataArray:(NSMutableArray*) dataArray{
    self = [super init];
    self.source_array = dataArray;

    return self;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_source_array count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_source_array objectAtIndex:row] ;
}



@end
