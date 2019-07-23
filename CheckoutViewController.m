//
//  CheckoutViewController.m
//  Приложение для кондитера
//
//  Created by User on 07/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "CheckoutViewController.h"
#import "ApplicationData.h"
#import "catalog-app/DeliveryMethod.h"
#import "catalog-app/DeliveryTime.h"
#import "UIPickerViewWithDataSourceProperty.h"
@interface CheckoutViewController ()

@end

@implementation CheckoutViewController

@synthesize scroll;
@synthesize nametextfield;
@synthesize pickerView;


- (void)viewDidLoad {
    [super viewDidLoad];
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(scroll.bounds.size.width, scroll.bounds.size.height*1.2)];
    _goodsPrice.text = _adb_rg;
    delivery_dates =[NSMutableArray arrayWithObjects:@"26.05.2019",@"27.05.2019",@"28.05.2019",@"29.05.2019",@"30.05.2019",nil];
    _deliveryDatesPicker = [[UIPickerViewWithDataSourceProperty alloc] initWithDataArray:delivery_dates];
    _deliveryDatesPicker.delegate = _deliveryDatesPicker;
    _deliveryDatesPicker.dataSource = _deliveryDatesPicker;
    [_deliveryTimeEditField setText:@"Выбирите дату доставки"];
    [_deliveryTimeEditField setInputView:_deliveryDatesPicker];
    
    delivery_times =[NSMutableArray arrayWithObjects:@"c 10 до 18",@"c 10 до 15",@"c 13 до 18",nil];
    _deliveryTimesPicker = [[UIPickerViewWithDataSourceProperty alloc] initWithDataArray:delivery_times];
    _deliveryTimesPicker.delegate = _deliveryTimesPicker;
    _deliveryTimesPicker.dataSource = _deliveryTimesPicker;
    [_deliveryCertainTime setInputView:_deliveryTimesPicker];
    
    _leadToFinalScreen.layer.cornerRadius =10;
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    _deliveryTimeEditField.inputAccessoryView = keyboardToolbar;
    _deliveryCertainTime.inputAccessoryView = keyboardToolbar;
    
    
    
//    _delivery_methods = [ApplicationData getDeliveryMethods];
//    _selectedDeliveryMethod = [_delivery_methods objectAtIndex:0];
//    _delivery_times = _selectedDeliveryMethod.deliveryTimes;
//    _deliveryTimesPicker = [[UIPickerViewWithDataSourceProperty alloc] initWithDataArray:_delivery_times];
//    _deliveryTimesPicker.delegate = _deliveryTimesPicker;
//    _deliveryTimesPicker.dataSource = _deliveryTimesPicker;
//
//
//    [_deliveryTimeEditField setText:@"Выбирите дату доставки"];
//    if (_selectedDeliveryMethod.isHasDeliveryTimes) {
//        [_deliveryTimeEditField setHidden:NO];
//    }else{
//        [_deliveryTimeEditField setHidden:YES];
//    }
//    [_deliveryTimeEditField setInputView:_deliveryTimesPicker];
//    _descriptor.text = _selectedDeliveryMethod.methodDescription;
//
//    _selectedDeliveryTime = [_delivery_times objectAtIndex:0];
//
//
//    // delivery times certain
//    _deliveryTimesCertainPicker = [[UIPickerViewWithDataSourceProperty alloc] initWithDataArray:_selectedDeliveryTime.deliveryTimesCertain];
//
//    _deliveryTimesCertainPicker.delegate = _deliveryTimesCertainPicker;
//    _deliveryTimesCertainPicker.dataSource = _deliveryTimesCertainPicker;
//
    
//    [_deliveryCertainTime setText:@"Выбирите время доставки"];
//    if (_selectedDeliveryTime.isHasDeliveryTimesCertain) {
//        [_deliveryCertainTime setHidden:NO];
//    }else{
//        [_deliveryCertainTime setHidden:YES];
//    }
//    [_deliveryCertainTime setInputView:_deliveryTimesCertainPicker];
    
    
    

    

}

-(void)yourTextViewDoneButtonPressed
{
    [_deliveryTimeEditField resignFirstResponder];
    [_deliveryCertainTime resignFirstResponder];
}

-(void) viewWillAppear:(BOOL)animated
{
  
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 27;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString * title = nil;
    int selected_row = [pickerView selectedRowInComponent:0];
    if (selected_row < 22){
        [_deliveryTimeEditField setText:@"Выбирите дату доставки"];
        [_deliveryCertainTime setText:@"Выбирите время доставки"];
        [_deliveryTimeEditField setHidden:NO];
        [_deliveryCertainTime setHidden:YES];
        [_mkadKilommeters setHidden:YES];
        [_kilommetersMkadLabel setHidden:YES];
        [_kilommetrsMkadStepper setHidden:YES];
    }
    else if(selected_row ==22){
        [_deliveryTimeEditField setText:@"Выбирите дату доставки"];
        [_deliveryCertainTime setText:@"Выбирите время доставки"];
        [_mkadKilommeters setText:@"0"];
        _kilommetrsMkadStepper.value =0;
        [_deliveryCertainTime setHidden:NO];
        [_kilommetersMkadLabel setText:@"Укажите расстояние от МКАД"];
        [_deliveryTimeEditField setHidden:NO];
        [_mkadKilommeters setHidden:NO];
        [_kilommetersMkadLabel setHidden:NO];
        [_kilommetrsMkadStepper setHidden:NO];
        
    }
    else if(selected_row==23){
        [_deliveryCertainTime setHidden:NO];
        [_kilommetersMkadLabel setText:@"Укажите количество остановок на метро"];
        [_deliveryCertainTime setText:@"Выбирите время доставки"];
        [_mkadKilommeters setText:@"0"];
        _kilommetrsMkadStepper.value =0;
        [_deliveryTimeEditField setHidden:NO];
        [_mkadKilommeters setHidden:NO];
        [_kilommetersMkadLabel setHidden:NO];
        [_kilommetrsMkadStepper setHidden:NO];
    }
    else if((selected_row>23) ||(selected_row<27) ){
        [_deliveryTimeEditField setText:@"Выбирите дату сборки"];
        [_deliveryTimeEditField setHidden:NO];
        [_deliveryCertainTime setHidden:YES];
        [_mkadKilommeters setHidden:YES];
        [_kilommetersMkadLabel setHidden:YES];
        [_kilommetrsMkadStepper setHidden:YES];
    }
    else{
        
    }
    //    [NSString stringWithFormat:@"%d", amount];
    //    NSRange match = [_deliveryPrice.text rangeOfString: @"₽"];
    //    _deliveryPrice.text = [_deliveryPrice.text substringWithRange: NSMakeRange (0, match.location)];
    //
    //     match = [_adb_rg rangeOfString: @"₽"];
    //    _adb_rg = [_adb_rg substringWithRange: NSMakeRange (0, match.location)];
    //
    //    _totalPriceWithDelivery.text =[NSString stringWithFormat:@"%d", [_deliveryPrice.text integerValue] + [ _adb_rg integerValue] ];
    
    NSRange match;
    match = [_adb_rg rangeOfString: @"₽"];
    int goodsPrice = [[_adb_rg substringWithRange: NSMakeRange (0, match.location)] intValue];
    
    match = [_deliveryPrice.text rangeOfString: @"₽"];
    int deliveryPrice = [[_deliveryPrice.text substringWithRange: NSMakeRange (0, match.location)] intValue];
    deliveryPriceGlobal = deliveryPrice;
    
    _totalPriceWithDelivery.text =@"1233 ₽";
    switch(row) {
        case 0:
            title = @"-- Выберите способ доставки --";
            _deliveryPrice.text =@"0 ₽";
            _descriptor.text =@"";
            break;
        case 1:
            title = @"Самовывоз Марьинский У-Г";
            _deliveryPrice.text =@"50 ₽";
            _descriptor.text =@"";
            break;
        case 2:
            title = @"Самовывоз Апрелевка";
             _deliveryPrice.text =@"159 ₽";
            _descriptor.text =@"";
            break;
        case 3:
            title = @"Самовывоз Братиславская";
             _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 4:
            title = @"Самовывоз Бутово";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;

        case 5:
            title = @"Самовывоз Зеленоград";
             _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;

        case 6:
            title = @"Самовывоз Китай-Город";
             _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;

        case 7:
            title = @"Самовывоз Красногорск";
             _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 8:
            title = @"Самовывоз Марьино";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 9:
            title = @"Самовывоз Маяковская";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 10:
            title = @"Самовывоз Молодежная";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 11:
            title = @"Самовывоз Новогиреево";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 12:
            title = @"Самовывоз Октябрьское поле";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 13:
            title = @"Самовывоз Планерная";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 14:
            title = @"Самовывоз Реутов";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 15:
            title = @"Самовывоз Рассказовка";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 16:
            title = @"Самовывоз Сокольники";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 17:
            title = @"Самовывоз Савеловская";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 18:
            title = @"Самовывоз Электрозаводская";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 19:
            title = @"Самовывоз Чертановская";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 20:
            title = @"Самовывоз Шоссе Энтузиастов";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 21:
            title = @"Самовывоз Яуза";
            _deliveryPrice.text =@"100 ₽";
            _descriptor.text =@"";
            break;
        case 22:
            title = @"Курьер в Подмосковье, за МКАД";
            _deliveryPrice.text =@"359 ₽";
            _descriptor.text =@"Доставка за МКАД осуществляется в течении 3-х рабочих дней после подтверждения заказа. Указанная дата доставки - это первый рабочий день, в который возможна доставка";
            break;
        case 23:
            title = @"Курьер по Москве, в пределах МКАД";
            _deliveryPrice.text =@"359 ₽";
            _descriptor.text =@"";
            break;
        case 24:
            title = @"Почта России";
            _deliveryPrice.text =@"390 ₽";
            _descriptor.text =@"После подтверждения заказа оператор скинет Вам счет на оплату с реквизитами.";
            break;
        case 25:
            title = @"EMC Почта";
            _deliveryPrice.text =@"990 ₽";
            _descriptor.text =@"После подтверждения заказа оператор скинет Вам счет на оплату с реквизитами.";
            break;
        case 26:
            title = @"PickPoint";
            _deliveryPrice.text =@"420 ₽";
            _descriptor.text =@"Посылка отправляется в Пик Пойнт через 1-2 дня после заказа. Оплата товара происходит в момент выдачи заказа. Вы можете отслеживать сами передвижение посылки на официальном сайте pickpoint.ru,набрав номер заказа в меню Мониторинг доставки.";
            break;
        case 27:
            title = @"Наложный платёж";
            _deliveryPrice.text =@"690 ₽";
            _descriptor.text =@"Посылки Наложенным платежом отправляются Почтой России. После подтверждения заказа посылка отправляется в течении 2-3 дней. Затем оператор скидывает номер отправления для отслеживания передвижения посылки.";
            break;
    }
    
 
    
    
    
    _totalPriceWithDelivery.text = [[NSMutableString alloc] initWithFormat:@"%d ₽",  deliveryPrice +goodsPrice];
    
//    DeliveryMethod *method = _delivery_methods[row];
//    _selectedDeliveryMethod = method;
//    _delivery_times= _selectedDeliveryMethod.deliveryTimes;
//    [_deliveryTimesPicker setHidden:YES];
//    _deliveryTimesPicker = [[UIPickerViewWithDataSourceProperty alloc] initWithDataArray:_delivery_times];
//    _deliveryTimesPicker.delegate = _deliveryTimesPicker;
//    _deliveryTimesPicker.dataSource = _deliveryTimesPicker;
//    [_deliveryTimeEditField setInputView:_deliveryTimesPicker];
    
//    if (_selectedDeliveryMethod.isHasDeliveryTimes) {
//        [_deliveryTimeEditField setHidden:NO];
//    }else{
//        [_deliveryTimeEditField setHidden:YES];
//    }
    return title;
        
        //[_deliveryTimesPicker reloadAllComponents];
//        UIPickerView *deliveryTimesPickers = (UIPickerView *)[pickerView viewWithTag:2];
//        if (_selectedDeliveryMethod.isHasDeliveryTimes) {
//             [deliveryTimesPickers setHidden:false];
//        }
//        [deliveryTimesPickers setHidden:true];
//        _descriptor.text =method.methodDescription;
    
//    }else{
//        DeliveryTime *delivery_time = _delivery_times[row];
//        return delivery_time.name;
//    }
}


- (IBAction)mkadEditDidBegan:(id)sender {
    UITextField *field = (UITextField*) sender;
    field.text = @"0";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)deliveryTimeEditDidEditEnd:(id)sender {
    UITextField *field = (UITextField*) sender;
    NSInteger row =[_deliveryDatesPicker selectedRowInComponent:0];
    field.text = [delivery_dates objectAtIndex:row];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)segmentChange:(id)sender {
    switch (self.segmentCtrl.selectedSegmentIndex) {
        case 0:
            self.descriptor.text = @"После подтверждения заказа оператор скинет Вам счет на оплату с реквизитами.";
            break;
        case 1:
            self.descriptor.text = @"После подтверждения заказа оператор скинет Вам счет на оплату с реквизитами.";
            break;
        case 2:
            self.descriptor.text = @"Посылка отправляется в PickPoint через 1-2 дня после заказа.Оплата товара происходит в момент выдачи заказа. Вы можете отслеживать сами передвижение посылки на официальном сайте pickpoint.ru,набрав номер заказа в меню Мониторинг доставки";
            break;
        case 3:
            self.descriptor.text = @"Посылки Наложенным платежом отправляются Почтой России. После подтверждения заказа посылка отправляется в течении 2-3 дней. Затем оператор скидывает номер отправления для отслеживания передвижения посылки.";
            break;
            
        default:
            break;
    }
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)mkadKillometersStepper:(id)sender {
    UIStepper *stepper = (UIStepper *) sender;
    
    stepper.maximumValue = 99;
    stepper.minimumValue = 0;
    double value = [stepper value];
    NSRange match;
    match = [_adb_rg rangeOfString: @"₽"];
    int goodsPrice = [[_adb_rg substringWithRange: NSMakeRange (0, match.location)] intValue];
    
    match = [_deliveryPrice.text rangeOfString: @"₽"];
    //int deliver = [[_deliveryPrice.text substringWithRange: NSMakeRange (0, match.location)] intValue];
    int deliveryPriceWithKillometers = deliveryPriceGlobal;
    if(_kilommetersMkadLabel.text == @"Укажите расстояние от МКАД"){
        deliveryPriceWithKillometers = deliveryPriceGlobal + (int)[_kilommetrsMkadStepper value]*25;
        _deliveryPrice.text =[[NSMutableString alloc] initWithFormat:@"%d ₽",  deliveryPriceWithKillometers];
    }
    
    [_mkadKilommeters setText:[NSString stringWithFormat:@"%d", (int)value]];
    _totalPriceWithDelivery.text = [[NSMutableString alloc] initWithFormat:@"%d ₽",  deliveryPriceWithKillometers +goodsPrice];
    
}
- (IBAction)deliveryTimeCertainSet:(id)sender {
    UITextField *field = (UITextField*) sender;
    NSInteger row =[_deliveryTimesPicker selectedRowInComponent:0];
    field.text = [delivery_times objectAtIndex:row];

}
- (IBAction)upOutside:(id)sender {
    NSLog(@"qweqwe");
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger currentLength = textField.text.length;
    NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
    
    if(textField.tag!=1){
        return YES;
    }
    
    if (range.length == 1) {
        return YES;
    }
    
    
    if ([numbers characterIsMember:[string characterAtIndex:0]]) {
        
        
        if ( currentLength == 3 )
        {
            
            if (range.length != 1)
            {
                
                NSString *firstThreeDigits = [textField.text substringWithRange:NSMakeRange(0, 3)];
                
                NSString *updatedText;
                
                if ([string isEqualToString:@"-"])
                {
                    updatedText = [NSString stringWithFormat:@"%@",firstThreeDigits];
                }
                
                else
                {
                    updatedText = [NSString stringWithFormat:@"%@-",firstThreeDigits];
                }
                
                [textField setText:updatedText];
            }
        }
        
        else if ( currentLength > 3 && currentLength < 8 )
        {
            
            if ( range.length != 1 )
            {
                
                NSString *firstThree = [textField.text substringWithRange:NSMakeRange(0, 3)];
                NSString *dash = [textField.text substringWithRange:NSMakeRange(3, 1)];
                
                NSUInteger newLenght = range.location - 4;
                
                NSString *nextDigits = [textField.text substringWithRange:NSMakeRange(4, newLenght)];
                
                NSString *updatedText = [NSString stringWithFormat:@"%@%@%@",firstThree,dash,nextDigits];
                
                [textField setText:updatedText];
                
            }
            
        }
        
        else if ( currentLength == 8 )
        {
            
            if ( range.length != 1 )
            {
                NSString *areaCode = [textField.text substringWithRange:NSMakeRange(0, 3)];
                
                NSString *firstThree = [textField.text substringWithRange:NSMakeRange(4, 3)];
                
                NSString *nextDigit = [textField.text substringWithRange:NSMakeRange(7, 1)];
                
                [textField setText:[NSString stringWithFormat:@"+7 (%@) %@-%@",areaCode,firstThree,nextDigit]];
            }
            
        }
    }
    
    else {
        return NO;
    }
    if(currentLength+1 >=18){
        return NO;
    }
    
    return YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if (![self validateEmailWithString:_emailField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Не корректный почтовый ящик" message:@"Заполните поле почтовый ящик правильно" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return false;
        
    }
    return true;
}


@end



