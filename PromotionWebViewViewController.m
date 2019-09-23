//
//  PromotionViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 15.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "PromotionWebViewViewController.h"

@interface PromotionWebViewViewController ()<WKNavigationDelegate>

@end

@implementation PromotionWebViewViewController


- (void)viewDidLoad {
    NSString *promotionPath = @"https://www.nevkusno.ru/discounts/";
    
    [super viewDidLoad];
    NSURLRequest *reqests =[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:promotionPath]];
    [self.webView loadRequest:reqests];
    self.webView.navigationDelegate =self;
    
}
- (void)webView:(WKWebView *)webView
didFinishNavigation:(WKNavigation *)navigation{
    NSString *jsCode = @"document.querySelectorAll('.b-header,.b-footer').forEach(e=>{e.style.display='none';})";
    [self.webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable arg, NSError * _Nullable error) {
        NSLog(@"error in js code");
    }];
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//
//    NSLog(@"request.URL.scheme: %@", request.URL.scheme);
//
//    BOOL calledForReload = NO;
//
//    if ([[request.URL.scheme lowercaseString] isEqualToString:@"about"]) {
//        //have we used reload yet?
//        if (!calledForReload) {
//            calledForReload = YES;
//            [webView reload];
//        } else {
//            // other response
//            // decide what you wish to do if you get another about:blank
//        }
//    }
//
//    return YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
