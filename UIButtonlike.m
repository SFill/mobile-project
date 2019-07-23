//
//  UIButtonlike.m
//  Приложение для кондитера
//
//  Created by User on 10/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "UIButtonlike.h"

@implementation UIButtonlike

-(void)buttonTouched:(id)sender
{
    UIButton *btn_action = (UIButton *)sender;
    
    if( [[btn_action imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"wishes"]])
    {
        [btn_action setImage:[UIImage imageNamed:@"wishes live1"] forState:UIControlStateNormal];
        // other statements....
    }
    else
    {
        [btn_action setImage:[UIImage imageNamed:@"wishes live1"] forState:UIControlStateNormal];
        // other statements....
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
