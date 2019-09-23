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
#import "ViewContollers/CityTableViewController.h"
#import "UIViewController+UIViewContollerWithSpinnerCategory.h"
#import "helpers/UIClassHelpers/UIPickerVilewWithTextField.h"
#import "DeliveryMapViewController.h"
#import "EndViewController.h"

@interface CheckoutViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property NSMutableArray *deliveryDates;
@end

@implementation CheckoutViewController

@synthesize scroll;
@synthesize nameTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(scroll.bounds.size.width, scroll.bounds.size.height*1.2)];
    self.goodsPriceLabel.text = [self.goodsPrice stringValue];
    self.pickPointAddress = @"";
    
    //textField picker inputs
    
    NSDate *currentDate = [[NSDate alloc] init];
    self.deliveryDates =[[NSMutableArray alloc] init];
    for (int i=1; i<15; i++) {
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setDay:i];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *dateFrom = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy"];
        NSString *dateString = [formatter stringFromDate:dateFrom];
        [self.deliveryDates addObject:dateString];
    }
    UIPickerView *deliveryDatesPicker = [[UIPickerVilewWithTextField alloc] initWithTextField:self.deliveryDateEditField andDataSource:self.deliveryDates];
    [self.deliveryDateEditField setText:self.deliveryDates[0]];
    [self.deliveryDateEditField setInputView:deliveryDatesPicker];
    
    self.delivery_times =[NSMutableArray arrayWithObjects:@"c 10 до 18",@"c 10 до 15",@"c 13 до 18",nil];
    UIPickerView *deliveryTimesPicker = [[UIPickerVilewWithTextField alloc] initWithTextField:self.deliveryTimeTextView andDataSource:self.delivery_times];
    [self.deliveryTimeTextView setText:self.delivery_times[0]];
    [self.deliveryTimeTextView setInputView:deliveryTimesPicker];
    
    
    //metro picker
    NSArray *metroDeliveryOptions =[NSMutableArray arrayWithObjects:@"до 2 км. (не более 7 остановок транспортом)",@"свыше 2 км. (более 7 остановок транспортом)",nil];
    UIPickerView *metroDeliveryOptionsPicker = [[UIPickerVilewWithTextField alloc] initWithTextField:self.metroRangeTextField andDataSource:metroDeliveryOptions];
    [self.metroRangeTextField setText:metroDeliveryOptions[0]];
    [self.metroRangeTextField setInputView:metroDeliveryOptionsPicker];
    

    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.deliveryDateEditField.inputAccessoryView = keyboardToolbar;
    self.deliveryTimeTextView.inputAccessoryView = keyboardToolbar;
    self.metroRangeTextField.inputAccessoryView = keyboardToolbar;
    
    //finalScreen button setup
    self.leadToFinalScreen.layer.cornerRadius =10;
    
    //copy items from cart (fix with different price and items in cart)
    self.fixedCart = [NSArray arrayWithArray:[ApplicationData getCart]];
    
    
    //load data from api
    [self showSpinner:self.view];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void){
        [ApplicationData getDeliveryMethodsWithPageNum:@1 inPage:@150 OnSuccess:^(NSDictionary *data) {
            self.deliveryMethods = [ApplicationData getDeliveryMethodsFromDict:data];
            dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
             dispatch_group_leave(group);
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.descriptor.hidden = YES;
        self.addressTextViews.hidden = YES;
        self.mkadViews.hidden = YES;
        self.deliveryDateEditField.hidden= NO;
        self.deliveryTimeTextView.hidden = YES;
        self.metroRangeTextField.hidden =YES;
        self.choicePostomatButtonWrapper.hidden = YES;
        NSMutableArray *bufferDeliveryMethods = [NSMutableArray new];
        NSMutableArray *whiteList = [self getDeliveryEnableMethodsIds];
        
        for (VMDeliveryMethod *method in self.deliveryMethods) {
            if ([whiteList containsObject:method.Id]) {
                [bufferDeliveryMethods addObject:method];
            }
        }
        self.deliveryMethods = bufferDeliveryMethods;
        self.deliveryMethod = self.deliveryMethods[0];
        [self updatePriceLabels];
        [self.pickerView reloadAllComponents];
        [self removeSpinner];
    });
}



-(void)yourTextViewDoneButtonPressed
{
    [_deliveryDateEditField resignFirstResponder];
    [_deliveryTimeTextView resignFirstResponder];
    [_metroRangeTextField resignFirstResponder];
}


-(NSMutableArray*) getDeliveryEnableMethodsIds{
    NSMutableArray *selfDeliveryMethodsIds = [NSMutableArray new];
    for (int i=32; i<53; i++) {
        [selfDeliveryMethodsIds addObject:@(i)];
    }
    [selfDeliveryMethodsIds addObject:@(121)];
    [selfDeliveryMethodsIds addObject:@(122)];
    [selfDeliveryMethodsIds addObject:@(123)];
    
    [selfDeliveryMethodsIds addObject:@(53)];
    [selfDeliveryMethodsIds addObject:@(54)];
    [selfDeliveryMethodsIds addObject:@(55)];
    
    [selfDeliveryMethodsIds addObject:@(26)];
    [selfDeliveryMethodsIds addObject:@(27)];
    [selfDeliveryMethodsIds addObject:@(30)];
    
    return  selfDeliveryMethodsIds;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    NSMutableArray *selfDeliveryMethodsIds = [self getDeliveryEnableMethodsIds];
    VMDeliveryMethod *deliveryMethod = [self.deliveryMethods objectAtIndex:row];
    self.deliveryMethod = deliveryMethod;
    [self.deliveryDateEditField setText: [self.deliveryDates objectAtIndex:0]];
    self.deliveryDateEditField.enabled=YES;
    
    [self updatePriceLabels];
    self.selectOrderDateLabel.text = @"Выбирите дату доставки";

    //  за мкад
    if ([deliveryMethod.Id  isEqual: @26]) {
        if (![deliveryMethod.itemDescription isEqualToString:@""]) {
            self.descriptor.text = deliveryMethod.itemDescription;
            self.descriptor.hidden = NO;
        }else{
            self.descriptor.text = @"";
            self.descriptor.hidden = YES;
        }
        self.addressTextViews.hidden = NO;
        self.mkadViews.hidden = NO;
        self.kilommetrsMkadStepper.value = 0;
        self.mkadKilommeters.text = @"0";
        self.deliveryDateEditField.hidden= NO;
        self.deliveryTimeTextView.hidden = NO;
        self.metroRangeTextField.hidden =YES;
        self.choicePostomatButtonWrapper.hidden = YES;
        
        self.metroRangeLabel.hidden = YES;
        self.selectOrderDateLabel.hidden = NO;
        self.selectOrderTimeLabel.hidden = NO;
        return;
    }
    // в пределах мкада
    if ([deliveryMethod.Id  isEqual: @27]) {
        if (![deliveryMethod.itemDescription isEqualToString:@""]) {
            self.descriptor.text = deliveryMethod.itemDescription;
            self.descriptor.hidden = NO;
        }else{
            self.descriptor.text = @"";
            self.descriptor.hidden = YES;
        }
        self.addressTextViews.hidden = NO;
        self.mkadViews.hidden = YES;
        self.deliveryDateEditField.hidden= NO;
        self.deliveryTimeTextView.hidden = NO;
        self.metroRangeTextField.hidden =NO;
        self.choicePostomatButtonWrapper.hidden = YES;
        
        self.metroRangeLabel.hidden = NO;
        self.selectOrderDateLabel.hidden = NO;
        self.selectOrderTimeLabel.hidden = NO;
        return;
    }
    // Срочная курьерская доставка по Москве день в день
    if ([deliveryMethod.Id  isEqual: @122]) {
        self.descriptor.text = deliveryMethod.itemDescription;
        self.descriptor.hidden = NO;
        self.addressTextViews.hidden = NO;
        self.mkadViews.hidden = YES;
        self.deliveryDateEditField.hidden= NO;
        self.deliveryTimeTextView.hidden = YES;
        self.metroRangeTextField.hidden =YES;
        self.choicePostomatButtonWrapper.hidden = YES;
        
        self.metroRangeLabel.hidden = YES;
        self.selectOrderDateLabel.hidden = NO;
        self.selectOrderTimeLabel.hidden = YES;
        return;
    }
    
    // pickPoint
    if ([deliveryMethod.Id  isEqual: @30]) {
        self.descriptor.text = deliveryMethod.itemDescription;
        self.descriptor.hidden = NO;
        self.addressTextViews.hidden = YES;
        self.mkadViews.hidden = YES;
        self.deliveryDateEditField.hidden= NO;
        self.deliveryTimeTextView.hidden = YES;
        self.metroRangeTextField.hidden =YES;
        self.choicePostomatButtonWrapper.hidden = NO;
        
        self.metroRangeLabel.hidden = YES;
        self.selectOrderDateLabel.hidden = NO;
        self.selectOrderTimeLabel.hidden = YES;
        return;
        
    }
    // почта
    if ([@[@53,@54,@55] containsObject:deliveryMethod.Id]) {
        self.descriptor.text = deliveryMethod.itemDescription;
        self.descriptor.hidden = NO;
        self.addressTextViews.hidden = NO;
        self.mkadViews.hidden = YES;
        self.deliveryDateEditField.hidden= NO;
        self.deliveryTimeTextView.hidden = YES;
        self.metroRangeTextField.hidden =YES;
        self.choicePostomatButtonWrapper.hidden = YES;
        
        [self.deliveryDateEditField setText: [self.deliveryDates objectAtIndex:6]];
        self.deliveryDateEditField.enabled=NO;
        
        self.metroRangeLabel.hidden = YES;
        self.selectOrderDateLabel.hidden = NO;
        self.selectOrderDateLabel.text = @"Дата сборки";
        self.selectOrderTimeLabel.hidden = YES;
        return;
    }
    if ([selfDeliveryMethodsIds containsObject:deliveryMethod.Id]) {
        if (![deliveryMethod.itemDescription isEqualToString:@""]) {
            self.descriptor.text = deliveryMethod.itemDescription;
            self.descriptor.hidden = NO;
        }else{
            self.descriptor.text = @"";
            self.descriptor.hidden = YES;
        }
        self.addressTextViews.hidden = YES;
        self.mkadViews.hidden = YES;
        self.deliveryDateEditField.hidden= NO;
        self.deliveryTimeTextView.hidden = YES;
        self.metroRangeTextField.hidden =YES;
        self.choicePostomatButtonWrapper.hidden = YES;
       
        self.metroRangeLabel.hidden = YES;
        self.selectOrderDateLabel.hidden = NO;
        self.selectOrderTimeLabel.hidden = YES;
        return;
    }
    
    self.descriptor.hidden = YES;
    self.addressTextViews.hidden = YES;
    self.mkadViews.hidden = YES;
    self.deliveryDateEditField.hidden= YES;
    self.deliveryTimeTextView.hidden = YES;
    self.metroRangeTextField.hidden =YES;
    self.choicePostomatButtonWrapper.hidden = YES;
    self.selectOrderDateLabel.hidden = YES;
    self.selectOrderTimeLabel.hidden = YES;
    self.metroRangeLabel.hidden = YES;
    
}

-(void) updatePriceLabels{
    if (self.deliveryMethod.priceType ==VMDeliveryMethodPriceSingle) {
        self.deliveryPriceLabel.text = [NSString stringWithFormat:@"%@ ₽", [self.deliveryMethod.price stringValue]];
        self.totalPriceWithDeliveryLabel.text = [NSString stringWithFormat:@"%@ ₽", [@([self.deliveryMethod.price doubleValue] +[self.goodsPrice doubleValue]) stringValue]];
    }else{
        NSMutableArray *priceRanges = self.deliveryMethod.priceRanges;
        for (VMPriceRange *priceRange in priceRanges) {
            if ([priceRange.minValue intValue] <= [self.goodsPrice intValue] &  [priceRange.maxValue intValue] >= [self.goodsPrice intValue]) {
                self.deliveryPriceLabel.text = [NSString stringWithFormat:@"%@ ₽", [priceRange.price stringValue]];
                self.totalPriceWithDeliveryLabel.text = [NSString stringWithFormat:@"%@ ₽", [@([priceRange.price doubleValue] +[self.goodsPrice doubleValue]) stringValue]];
            }
        }
    }
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"%@ ₽", [self.goodsPrice stringValue]];
    
}

-(void) changeDeliveryMethod:(VMDeliveryMethod*) deliveryMethod{
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.deliveryMethods count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    VMDeliveryMethod *deliveryMethod = self.deliveryMethods[row];
    return deliveryMethod.name;
    
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
//    UITextField *field = (UITextField*) sender;
//    NSInteger row =[_deliveryDatesPicker selectedRowInComponent:0];
//    field.text = [delivery_dates objectAtIndex:row];
}


- (IBAction)segmentChange:(id)sender {
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)mkadKillometersStepper:(id)sender {
    UIStepper *stepper = (UIStepper *) sender;
    
    stepper.maximumValue = 99;
    stepper.minimumValue = 0;
    
    int pricePerKM = 25;
    
    double value = [stepper value];
    
    NSNumber *newDeliveyPrice= @([self.deliveryMethod.price doubleValue]+ pricePerKM*value);
    
    NSNumber *newTotalPrice= @([newDeliveyPrice doubleValue]+[self.goodsPrice doubleValue]);
    
    [self.mkadKilommeters setText:[NSString stringWithFormat:@"%d", (int)value]];
    [self.deliveryPriceLabel setText:[NSString stringWithFormat:@"%@ ₽",[newDeliveyPrice stringValue]]];
     [self.totalPriceWithDeliveryLabel setText:[NSString stringWithFormat:@"%@ ₽",[newTotalPrice  stringValue]]];
    
//    match = [self.price rangeOfString: @"₽"];
//    int goodsPrice = [[_price substringWithRange: NSMakeRange (0, match.location)] intValue];
//
//    match = [_deliveryPrice.text rangeOfString: @"₽"];
//    int deliveryPriceWithKillometers = deliveryPriceGlobal;
//    if(_kilommetersMkadLabel.text == @"Укажите расстояние от МКАД"){
//        deliveryPriceWithKillometers = deliveryPriceGlobal + (int)[_kilommetrsMkadStepper value]*25;
//        _deliveryPrice.text =[[NSMutableString alloc] initWithFormat:@"%d ₽",  deliveryPriceWithKillometers];
//    }
//

//    _totalPriceWithDelivery.text = [[NSMutableString alloc] initWithFormat:@"%d ₽",  deliveryPriceWithKillometers +goodsPrice];
    
}
- (IBAction)deliveryTimeCertainSet:(id)sender {
//    UITextField *field = (UITextField*) sender;
//    NSInteger row =[_deliveryTimesPicker selectedRowInComponent:0];
//    field.text = [delivery_times objectAtIndex:row];

}
- (IBAction)upOutside:(id)sender {
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    email = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSUInteger currentLength = textField.text.length;
//    NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
//    
//    if(textField.tag!=1){
//        return YES;
//    }
//    
//    if (range.length == 1) {
//        return YES;
//    }
//    
//    
//    if ([numbers characterIsMember:[string characterAtIndex:0]]) {
//        
//        
//        if ( currentLength == 3 )
//        {
//            
//            if (range.length != 1)
//            {
//                
//                NSString *firstThreeDigits = [textField.text substringWithRange:NSMakeRange(0, 3)];
//                
//                NSString *updatedText;
//                
//                if ([string isEqualToString:@"-"])
//                {
//                    updatedText = [NSString stringWithFormat:@"%@",firstThreeDigits];
//                }
//                
//                else
//                {
//                    updatedText = [NSString stringWithFormat:@"%@-",firstThreeDigits];
//                }
//                
//                [textField setText:updatedText];
//            }
//        }
//        
//        else if ( currentLength > 3 && currentLength < 8 )
//        {
//            
//            if ( range.length != 1 )
//            {
//                
//                NSString *firstThree = [textField.text substringWithRange:NSMakeRange(0, 3)];
//                NSString *dash = [textField.text substringWithRange:NSMakeRange(3, 1)];
//                
//                NSUInteger newLenght = range.location - 4;
//                
//                NSString *nextDigits = [textField.text substringWithRange:NSMakeRange(4, newLenght)];
//                
//                NSString *updatedText = [NSString stringWithFormat:@"%@%@%@",firstThree,dash,nextDigits];
//                
//                [textField setText:updatedText];
//                
//            }
//            
//        }
//        
//        else if ( currentLength == 8 )
//        {
//            
//            if ( range.length != 1 )
//            {
//                NSString *areaCode = [textField.text substringWithRange:NSMakeRange(0, 3)];
//                
//                NSString *firstThree = [textField.text substringWithRange:NSMakeRange(4, 3)];
//                
//                NSString *nextDigit = [textField.text substringWithRange:NSMakeRange(7, 1)];
//                
//                [textField setText:[NSString stringWithFormat:@"+7 (%@) %@-%@",areaCode,firstThree,nextDigit]];
//            }
//            
//        }
//    }
//    
//    else {
//        return NO;
//    }
//    if(currentLength+1 >=18){
//        return NO;
//    }
//    
    return YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
//    if (([identifier isEqualToString:@"Complete"])&![self validateEmailWithString:_emailField.text]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Не корректный почтовый ящик" message:@"Заполните поле почтовый ящик правильно" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        return false;
//
//    }
    return true;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toDeliveryMap"]) {
        DeliveryMapViewController *vc = [segue destinationViewController];
        vc.updateBlock = ^(NSDictionary * _Nonnull data) {
            NSString *address =[data objectForKey:@"address"];
            if (address == nil) {
                return;
            }
            self.pickPointAddress =address;
        };
    }
}

- (IBAction)selectCity:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CityTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CityTableViewController"];
    vc.calbackBlock = ^(PickPointCity * _Nonnull city) {
        self.city = city;
        [self.cityLabel setTitle:city.name forState:UIControlStateNormal];
    };
   // [self presentCard:vc];
}
- (IBAction)showDeliveryMap:(id)sender {
    [self performSegueWithIdentifier:@"toDeliveryMap" sender:sender];
}

-(BOOL) validatePhoneNumber:(NSString*) phone{
    phone = [phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *phoneRegex = @"((\\+7|7|8)+([0-9]){10})";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}
-(BOOL) validateAddressFields{
    if ( self.addressRoom.text.length == 0) {
        return NO;
    }
    if ( self.userIndex.text.length == 0) {
        return NO;
    }
    if ( self.userAddress.text.length == 0) {
        return NO;
    }
    return YES;
    
}

- (IBAction)createOrder:(id)sender {
    NSString* email = self.emailField.text;
    NSString* __block userPassword = [[[NSUUID UUID].UUIDString componentsSeparatedByString:@"-"] objectAtIndex:0];
    BOOL __block success = false;
    NSString __block *responseMessage = @"";
    BOOL __block authError = NO;
    dispatch_group_t group = dispatch_group_create();
    
    //проверка авторизации перед заказом
    BOOL __block isAuthedUser = [ApplicationData isAuthedUser];
    
    //проверка почты для неавторизированного пользователя, ибо у вошедшего пользователя она есть в профиле
    if (!isAuthedUser && ![self validateEmailWithString:email]) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Не корректный почтовый ящик"
                                    message:@"Заполните поле email правильно"
                                    preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:nil];
        [alert addAction:defaultAction];

        
        return;
    }
    //проверка номера
    if (![self validatePhoneNumber:self.phoneTextField.text]) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Не корректный телефонный номер"
                                    message:@"Заполните поле телефон правильно"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    if (self.nameTextField.text.length ==0) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Не заполнено поле имени"
                                    message:@"Заполните поле Имя"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    if (self.lastNameTextField.text.length ==0) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Не заполнено поле фамилии"
                                    message:@"Заполните поле фамилия"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    if ([@[@53,@54,@55,@122,@27,@26] containsObject:self.deliveryMethod.Id] &&  ![self validateAddressFields]) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Не заполнены адресные поля"
                                    message:@"Заполните поля адреса"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
        
    }
    
    //запись данных в объект заказа
    VMCreateOrderObject __block *createOrderObject = [[VMCreateOrderObject alloc] init];
    createOrderObject.deliveryDate = self.deliveryDateEditField.text;
    createOrderObject.deliveryTime = self.deliveryTimeTextView.text;
    createOrderObject.deliveryType = [self.deliveryMethod.Id stringValue];
    createOrderObject.deliveryDistance = [@(self.kilommetrsMkadStepper.value) stringValue];
    createOrderObject.deliveryUnderground = self.metroRangeTextField.text;
    createOrderObject.deliveryPickPointAddress = self.pickPointAddress;
    
    
    createOrderObject.userName = self.nameTextField.text;
    createOrderObject.userLastName = self.lastNameTextField.text;
    createOrderObject.userPhone = self.phoneTextField.text;
    
    
    createOrderObject.addressRoom = self.addressRoom.text;
    createOrderObject.userAddress = self.userAddress.text;
    createOrderObject.userIndex = self.userIndex.text;
    createOrderObject.items = [[NSMutableArray alloc] init];
    for (Product *product in self.fixedCart) {
        [createOrderObject.items addObject:[product getDataForOrderCreateObject]];
    }
    
    //отправка данных
    [self showSpinner:self.view];
    dispatch_group_enter(group);
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void){
        if (isAuthedUser) {
            [ApplicationData createOrderWithDict:[createOrderObject toDict] onSuccess:^(NSDictionary *data) {
                [ApplicationData cleanCart];
                success=YES;
                dispatch_group_leave(group);
            } onFailure:^(NSString *message) {
                success=NO;
                responseMessage = message;
                dispatch_group_leave(group);
                
            }];
        }else{
            
            [ApplicationData registerUserWithFirstName:createOrderObject.userName lastName:createOrderObject.userLastName login:email password:userPassword onSuccess:^(NSDictionary *data) {
                [ApplicationData createOrderWithDict:[createOrderObject toDict] onSuccess:^(NSDictionary *data) {
                    [ApplicationData cleanCart];
                    success=YES;
                    dispatch_group_leave(group);
                } onFailure:^(NSString *message) {
                    success=NO;
                    responseMessage = message;
                    dispatch_group_leave(group);
                    
                }];
            } onFailure:^(NSString *message) {
                success=NO;
                authError = YES;
                responseMessage = message;
                dispatch_group_leave(group);
            }];
        }
        
    });
    //обработка результата отправки
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (success) {
            NSLog(@"order was created");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            EndViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EndViewController"];
            NSString *text;
            if (isAuthedUser) {
                text = @"Наш оператор свяжется с вами в ближайшее врямя для подтверждения заказа.";
            }else{
                text = [NSString stringWithFormat:@"Вы сделали заказ и были зарегистрированы как пользователь, на указанный вами почтовый адрес отправлено письмо, для подтверждения почты необходимо перейти по ссылки из письма. Ваша почта: %@ \nВаш новый пароль: %@ \nНаш оператор свяжется с вами в ближайшее врямя для подтверждения заказа.", email,userPassword];
            }
            vc.text = text;
            [self presentViewController:vc animated:YES completion:^{
            }];
           // [self.navigationController popToRootViewControllerAnimated:NO];
            [self.tabBarController setSelectedIndex:0];
            
            [self removeSpinner];
        }else{
            if (authError) {
                responseMessage = @"Такой пользователь уже зарегистрирован, если учетная запись пренадлежит вам просьба войти в личный кабинет для оформления заказа";
                [self.tabBarController setSelectedIndex:3];
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:responseMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
            [controller presentViewController:alert animated:YES completion:nil];
            [self removeSpinner];
        }
    });
    
    
    
    
}

@end



