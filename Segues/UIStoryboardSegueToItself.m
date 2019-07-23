//
//  UIStoryboardSegueToItself.m
//  Приложение для кондитера
//
//  Created by Никита  on 12.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "UIStoryboardSegueToItself.h"

@implementation UIStoryboardSegueToItself


-(void) perform{
    [[[self sourceViewController] navigationController] pushViewController:[self destinationViewController] animated:YES];
}
@end
