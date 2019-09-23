//
//  Product.m
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "Product.h"

@implementation Product

-(NSDictionary*) getDataForOrderCreateObject{
    NSDictionary *data = @{@"id":[self.itemId stringValue],@"amount":self.amount,@"Currency":@"RUB"};
    return data;
}

@end
