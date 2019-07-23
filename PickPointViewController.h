//
//  PickPointViewController.h
//  Приложение для кондитера
//
//  Created by Никита  on 06.06.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface PickPointViewController : ViewController
@property (weak, nonatomic) IBOutlet WKWebView *videoView;
//@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

NS_ASSUME_NONNULL_END
