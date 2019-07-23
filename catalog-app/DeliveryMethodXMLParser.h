//
//  DeliveryMethodXMLParser.h
//  Приложение для кондитера
//
//  Created by Игорь on 24.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DeliveryMethod.h"
#import <Foundation/Foundation.h>

@interface DeliveryMethodXMLParser :NSObject <NSXMLParserDelegate>{
    NSMutableArray *deliveryMethods;
    NSMutableDictionary *deliveryMethodDict;
    NSMutableDictionary *deliveryTimeDict;
    NSMutableArray *deliveryTimesArray;
    NSMutableString *currentName;
    NSString *currentElement;
}


-(NSMutableArray*) parse;
@end

