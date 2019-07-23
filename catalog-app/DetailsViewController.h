//
//  DetailsViewController.h
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ApplicationData.h"
#import "Product.h"


@interface DetailsViewController : UIViewController

@property(strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCtrl;
- (IBAction)segmentChange:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *descriptor;
@property (weak, nonatomic) IBOutlet UIButton *addToCartPlusOneButton;

- (IBAction)addToCartPlusOne:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *leadToCart;
@property (weak, nonatomic) IBOutlet WKWebView *webViewDescription;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (nonatomic, retain) Product *product;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@end
