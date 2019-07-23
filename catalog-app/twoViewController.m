//
//  twoViewController.m
//  Приложение для кондитера
//
//  Created by Игорь on 26/12/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "twoViewController.h"
#import "ViewController1.h"

@interface twoViewController ()

@end

@implementation twoViewController
/*@synthesize strimg, image2, strpri ,pricelabel, strname, namelabel, strves, ves, strotziv, otzivi, strcountry, country;
- (void)viewDidLoad {
    [super viewDidLoad];
    image2.image=[UIImage imageNamed:strimg];
    pricelabel.text=strpri;
    namelabel.text=strname;
    ves.text=strves;
    otzivi.text=strotziv;
    country.text=strcountry;
    
    
   
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 79, 637, 770)];
    
    [self.view addSubview:_scrollView];
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width, _scrollView.bounds.size.height*1.2)];
    
    [_scrollView addSubview:image2];
    [_scrollView addSubview:pricelabel];
    [_scrollView addSubview:namelabel];
    [_scrollView addSubview:_stars];
    [_scrollView addSubview:otzivi];
    [_scrollView addSubview:_line1];
    [_scrollView addSubview:_nali];
    [_scrollView addSubview:_labeldostavka];
    [_scrollView addSubview:_your_city];
    [_scrollView addSubview:_city_buttom];
    [_scrollView addSubview:_line2];
    [_scrollView addSubview:_strana];
    [_scrollView addSubview:country];
    [_scrollView addSubview:_vess];
    [_scrollView addSubview:ves];
    [_scrollView addSubview:_click];
    [_scrollView addSubview:_diskription];
    
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
