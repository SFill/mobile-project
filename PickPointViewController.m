//
//  PickPointViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 06.06.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "PickPointViewController.h"

@interface PickPointViewController ()

@end

@implementation PickPointViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width, _scrollView.bounds.size.height*1.2)];
    NSString *videoURL = @"http://www.youtube.com/embed/_zPEx5cTmOI";
    _videoView.backgroundColor = [UIColor clearColor];
    _videoView.opaque = NO;
    
    
    NSString *videoHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <head>\
                           <style type=\"text/css\">\
                           iframe {position:absolute; top:50%%; margin-top:-130px;}\
                           body {background-color:#000; margin:0;}\
                           </style>\
                           </head>\
                           <body>\
                           <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                           </body>\
                           </html>", videoURL];
    
    [_videoView loadHTMLString:videoHTML baseURL:nil];
    // Do any additional setup after loading the view.
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
