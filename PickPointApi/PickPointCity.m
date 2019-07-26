//
//  PickPointCity.m
//  nevkusno
//
//  Created by Никита  on 25.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "PickPointCity.h"

@implementation PickPointCity
-(NSString*) nameFistLetter{
    return [self.name substringWithRange:NSMakeRange(0, 1)];
}
@end
