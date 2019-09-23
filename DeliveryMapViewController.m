//
//  DeliveryMapViewController.m
//  nevkusno
//
//  Created by Никита  on 23.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DeliveryMapViewController.h"

@interface DeliveryMapViewController ()<MKMapViewDelegate,WKScriptMessageHandler,WKNavigationDelegate>

@end

@implementation DeliveryMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deliveryMap.delegate =self;
//    NSString *html = @"<html><head><script type=\"text/javascript\" src=\"https://pickpoint.ru/select/postamat.js\" charset=\"utf-8\"></script></head><body><script>my_func=function(val){};ff=function(){PickPoint.open(my_func,{ikn: '9990544011'})}</script><button onClick=""></button></body></html>";
    //[self.locationManager startUpda
    CLLocation *location = [self.locationManager location];
    [self centerMapOnLocation:location];
    [self setAnnotaions:location];
    
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    [userController addScriptMessageHandler:self name:@"toController"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userController;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    //NSURL *url = [[NSBundle mainBundle] URLForResource: @"ModelPage" withExtension: @"html"];
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost:8080/pickpoint/#"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    [self.webView loadRequest: request];
    self.webView.navigationDelegate =self;
    [self.view addSubview:self.webView];
    
    //[self.webView loadFileURL:[NSURL] allowingReadAccessToURL:<#(nonnull NSURL *)#>]
    // Do any additional setup after loading the view.
}

//- (void)webView:(WKWebView *)webView
//didFinishNavigation:(WKNavigation *)navigation{
//    NSString *jsCode = @"PickPoint.open(my_function, {fromcity:'Владимир'});return false";
//    [self.webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable arg, NSError * _Nullable error) {
//        NSLog(@"error in js code");
//    }];
//}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSDictionary *pickPointResponse = (NSDictionary*) message.body;
    self.updateBlock(pickPointResponse);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) centerMapOnLocation:(CLLocation*) location{
    CLLocationDistance locationDistance = 1000;
    MKCoordinateRegion rg =  MKCoordinateRegionMakeWithDistance(location.coordinate, locationDistance, locationDistance);
    [self.deliveryMap setRegion:rg];
    
}
-(void) setAnnotaions:(CLLocation*) location{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]  init];
    [annotation setCoordinate:location.coordinate];
    [annotation setTitle:@"Ты здесь"];
    [self.deliveryMap addAnnotation:annotation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
