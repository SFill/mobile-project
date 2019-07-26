//
//  DetailsViewController.m
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "DetailsViewController.h"
#import "../ReviewsViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *ves;
@property (weak, nonatomic) IBOutlet UILabel *stars;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UIButton *addToCart;



@end

@implementation DetailsViewController
@synthesize scroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(scroll.bounds.size.width, scroll.bounds.size.height*1.2)];
    
    self.nameLabel.text = self.product.name;
    self.descriptionTextView.text = self.product.pDescription;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ ₽",self.product.price];
    self.ImageView.image = self.product.detailImg;
    self.ves.text = self.product.ves;
    self.country.text = self.product.city;
    self.stars.text = self.product.stars;
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    [self.webViewDescription loadHTMLString:[headerString stringByAppendingString:self.product.pDescription] baseURL:[[NSURL alloc] initWithString:@"https://nevkusno.ru/"]];
    NSString *star = @"★";
    NSString *emptyStar = @"☆";
    NSMutableString *rateStarString = [[NSMutableString alloc]init];
    int end =[self.product.stars intValue];
    for (int i=0; i<end; i++) {
        [rateStarString appendString:star];
    }
    for (int i=end; i<5; i++) {
        [rateStarString appendString:emptyStar];
    }
    self.rateLabel.text = rateStarString;
   
    
    _addToCart.layer.cornerRadius =10;
     _leadToCart.layer.cornerRadius =10;
    
    _addToCartPlusOneButton.layer.cornerRadius =10;
    
     [_addToCart setTitle:[NSString stringWithFormat:@ "В корзину  •  %d ₽", [self.product.price integerValue]]forState:UIControlStateNormal];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate =self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager startUpdatingLocation];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addToCart:(id)sender
{
    if ([self.product.stocks_quantity integerValue]<1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"К сожалению товар закончился" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    UIButton *button = _addToCart;
   // 343 55
//    CGSize stringSize = [self.myButton.titleLabel.text sizeWithFont:self.myButton.titleLabel.font];
   // CGRect frame = button.frame;
    
    
    
    Product* product = [ApplicationData searchCart:self.product];
    
    if(product ==nil){
        [ApplicationData addToCart:self.product];
        [_leadToCart setTitle:[NSString stringWithFormat:@ "В корзине  %d шт", 1]forState:UIControlStateNormal];
        
    }else{
        [_leadToCart setTitle:[NSString stringWithFormat:@ "В корзине  %d шт", [product.amount integerValue]]forState:UIControlStateNormal];
    }
    button.hidden = true;
    
    
    
    }

- (IBAction)segmentChange:(id)sender {
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    NSString *hasInfoString = [NSString stringWithFormat:@"<p>В наличии %@ %@</p>", [self.product.stocks_quantity stringValue],[self.product unit]];
    switch (self.segmentCtrl.selectedSegmentIndex) {
        case 0:
            [self.webViewDescription loadHTMLString:[headerString stringByAppendingString:self.product.pDescription] baseURL:nil];
            break;
        case 1:
            [self.webViewDescription loadHTMLString:[headerString stringByAppendingString:hasInfoString] baseURL:nil];
            break;
            
        default:
            break;
    }
}


- (IBAction)addToCartPlusOne:(id)sender {
    Product* product = [ApplicationData searchCart:self.product];
    [ApplicationData addToCart:self.product];
    if(product ==nil){
        [_leadToCart setTitle:[NSString stringWithFormat:@ "В корзине  %d шт", 1]forState:UIControlStateNormal];
        
    }else{
        [_leadToCart setTitle:[NSString stringWithFormat:@ "В корзине  %d шт", [product.amount integerValue]]forState:UIControlStateNormal];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"Reviews"])
    {
        ReviewsViewController *vc = [segue destinationViewController];
        vc.reviews = self.product.reviews;
        
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations objectAtIndex:0];
    [self.locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       NSString *city = [placemark locality];
                       [self.locationButton setTitle:city forState:UIControlStateNormal];
                   }];
}

@end

