//
//  UIPickerVilewWithTextField.m
//  nevkusno
//
//  Created by Никита  on 28.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "UIPickerVilewWithTextField.h"

@implementation UIPickerVilewWithTextField

-(instancetype) initWithTextField: (UITextField*) textField andDataSource:(NSArray*)
dataSource{
    self = [super init];
    if (self) {
        self.textField = textField;
        self.dataSorceArray = dataSource;
    }
    self.delegate = self;
    self.dataSource = self;
    return self;
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    self.textField.text=[self.dataSorceArray objectAtIndex:row];
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  [self.dataSorceArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataSorceArray[row];
}



@end
