//
//  UIViewController+UIViewContollerWithSpinnerCategory.m
//  Приложение для кондитера
//
//  Created by Никита  on 11.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "UIViewController+UIViewContollerWithSpinnerCategory.h"
#import <objc/runtime.h>

static void *ResultKey;
@implementation UIViewController (UIViewContollerWithSpinnerCategory)

- (void) showSpinner:(UIView*)onView{
    UIView *spinnerView = [[UIView alloc] initWithFrame:onView.bounds];
    spinnerView.backgroundColor = [[UIColor alloc] initWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [ai startAnimating];
    ai.center =spinnerView.center;
    dispatch_async(dispatch_get_main_queue(), ^{
        [spinnerView addSubview:ai];
        [onView addSubview:spinnerView];
    });
 objc_setAssociatedObject(self, &ResultKey, spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(void) removeSpinner{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *spinnerView = (UIView*)objc_getAssociatedObject(self, &ResultKey);
        [spinnerView removeFromSuperview];
        spinnerView = nil;
        
    });
}
@end
