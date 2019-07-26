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

@interface CheckoutViewController : UIViewController<UITextFieldDelegate>{
    DeliveryMethod *_selectedDeliveryMethod;
    DeliveryTime *_selectedDeliveryTime;
    NSMutableArray *delivery_dates;
    NSMutableArray *delivery_times;
    int deliveryPriceGlobal;
}

@property (weak, nonatomic) IBOutlet NSString *adb_rg;
@property (weak, nonatomic) IBOutlet NSMutableArray *delivery_methods;
@property (weak, nonatomic) IBOutlet NSMutableArray *delivery_times;
@property (strong, nonatomic) IBOutlet UIPickerViewWithDataSourceProperty *deliveryDatesPicker;
@property (strong, nonatomic) IBOutlet UIPickerViewWithDataSourceProperty *deliveryTimesPicker;
@property (weak, nonatomic) IBOutlet UITextField *deliveryTimeEditField;

@property (weak, nonatomic) IBOutlet UITextField *nametextfield;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *deliveryPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceWithDelivery;

@property(strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCtrl;
- (IBAction)segmentChange:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *descriptor;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *deliveryCertainTime;

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

@end

