//
//  CheckoutViewController.h
//  Приложение для кондитера
//
//  Created by User on 07/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
# import "UIPickerViewWithDataSourceProperty.h"
#import "catalog-app/DeliveryMethod.h"
#import "catalog-app/DeliveryTime.h"
#import "PickPointApi/PickPointCity.h"
#import "MarketApi/dto/VMDeliveryMethod.h"
#import "MarketApi/dto/VMPriceRange.h"
#import "MarketApi/dto/VMCreateOrderObject.h"

@interface CheckoutViewController : UIViewController<UITextFieldDelegate>{
    DeliveryMethod *_selectedDeliveryMethod;
    DeliveryTime *_selectedDeliveryTime;
//    NSMutableArray *delivery_dates;
 //   NSMutableArray *delivery_times;
    int deliveryPriceGlobal;
}

@property (nonatomic)  NSNumber *goodsPrice;
@property (nonatomic)  NSString *pickPointAddress;
@property (nonatomic)  NSArray *fixedCart;
@property (weak, nonatomic)  NSMutableArray *delivery_methods;
@property (weak, nonatomic)  NSMutableArray *delivery_times;

@property (nonatomic)  NSMutableArray *deliveryMethods;
@property (nonatomic)  VMDeliveryMethod *deliveryMethod;

//@property (strong, nonatomic)  UIPickerViewWithDataSourceProperty *deliveryDatesPicker;
//@property (strong, nonatomic)  UIPickerViewWithDataSourceProperty *deliveryTimesPicker;
@property (weak, nonatomic) IBOutlet UITextField *deliveryDateEditField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *userAddress;
@property (weak, nonatomic) IBOutlet UITextField *userIndex;
@property (weak, nonatomic) IBOutlet UITextField *addressRoom;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliveryPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceWithDeliveryLabel;

@property(strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCtrl;
- (IBAction)segmentChange:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *descriptor;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *deliveryTimeTextView;

- (IBAction)mkadKillometersStepper:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mkadKilommeters;
- (IBAction)deliveryTimeCertainSet:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *kilommetersMkadLabel;
@property (weak, nonatomic) IBOutlet UIStepper *kilommetrsMkadStepper;
@property (weak, nonatomic) IBOutlet UIButton *leadToFinalScreen;
- (IBAction)upOutside:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *cityLabel;
@property PickPointCity *city;
@property (weak, nonatomic) IBOutlet UIView *addressTextViews;
@property (weak, nonatomic) IBOutlet UIView *mkadViews;
@property (weak, nonatomic) IBOutlet UIView *totalViews;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UITextField *metroRangeTextField;
@property (weak, nonatomic) IBOutlet UIButton *choicePostomatButton;
@property (weak, nonatomic) IBOutlet UIView *choicePostomatButtonWrapper;
@property (weak, nonatomic) IBOutlet UILabel *metroRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectOrderDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectOrderTimeLabel;

@end

