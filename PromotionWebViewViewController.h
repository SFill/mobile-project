//
//  PromotionViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 15.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PromotionWebViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

NS_ASSUME_NONNULL_END
