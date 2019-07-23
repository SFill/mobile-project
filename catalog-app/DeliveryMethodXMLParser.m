//
//  DeliveryMethodXMLParser.m
//  Приложение для кондитера
//
//  Created by Игорь on 24.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DeliveryMethodXMLParser.h"
#import "DeliveryMethod.h"
#import "DeliveryTime.h"
#import "DeliveryTimeCertain.h"
//#import "../RaptureXML/RXMLElement.h"

@implementation DeliveryMethodXMLParser

-(NSMutableArray*) parse
{
    deliveryMethods = [[NSMutableArray alloc] init];
//    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"deliveryMethods.xml"];
//    
//    [rootXML iterate:@"item" usingBlock: ^(RXMLElement *e) {
//        DeliveryMethod *method =[[DeliveryMethod alloc] init];
//        method.itemId = [e attribute:@"itemId"];
//        method.name = [e attribute:@"name"];
//        method.price = [e attribute:@"price"];
//        method.methodDescription = [e attribute:@"description"];
//        [method setHasDeliveryTimes:[[e attribute:@"isHasDeliveryTimes"] boolValue] ];
//        NSMutableArray *_deliveryTimes = [[NSMutableArray alloc] init];
//
//
//        
//        NSLog(@"Item #%@", [e attribute:@"name"]);
//        
//        [e iterate:@"deliveryTime" usingBlock:^(RXMLElement *e) {
//            NSMutableArray *_deliveryTimesCertain = [[NSMutableArray alloc] init];
//            DeliveryTime *delivery_time =[[DeliveryTime alloc] init];
//            delivery_time.name = [e attribute:@"name"];
//            
//            [delivery_time setHasDeliveryTimesCertain:[[e attribute:@"isHasDeliveryTimesCertain"] boolValue] ];
//            
//            NSLog(@"deliveryTime #%@", [e attribute:@"name"]);
//            [e iterate:@"deliveryTimeCertain" usingBlock:^(RXMLElement *e) {
//                DeliveryTimeCertain *delivery_time_certain =[[DeliveryTimeCertain alloc] init];
//                delivery_time_certain.name = [e attribute:@"name"];
//                NSLog(@"deliveryTimeCertain #%@", [e attribute:@"name"]);
//                [_deliveryTimesCertain addObject:delivery_time_certain];
//            }];
//            delivery_time.deliveryTimesCertain = _deliveryTimesCertain;
//            [_deliveryTimes addObject:delivery_time];
//        }];
//        method.deliveryTimes = _deliveryTimes;
//        [deliveryMethods addObject:method];
//    }];

    
    return deliveryMethods;
}

//-(void)parser:(NSXMLParser*)parser
//didStartElement:(NSString*)elementName
// namespaceURI:(NSString*)namespaceURI
//qualifiedName:(NSString*)qualifiedName
//   attributes:(NSDictionary *)attributeDict
//{
//
//    NSLog(@"Element name %@", elementName );
//
//    if ([elementName isEqualToString:@"item"])
//    {
//        NSLog(@"Element name %@", elementName );
//
//        DeliveryMethod *delivery_method = [[DeliveryMethod alloc] init];
//
//        delivery_method.name = [attributeDict valueForKey:@"name"];
//        delivery_method.methodDescription = [attributeDict valueForKey:@"description"];
//        //delivery_method.deliveryTimes = [attributeDict valueForKey:@"delivery"];
//        [deliveryMethods addObject:delivery_method];
//    }
//
//}


//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    if(deliveryMethodDict && !deliveryTimesArray){
//        [deliveryMethodDict setObject:string forKey:currentElement];
//    }
//    else if(deliveryTimesArray && deliveryTimeDict) {
//        [deliveryTimeDict setObject:string forKey:currentElement];
//    }
//}

//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    if([elementName isEqualToString:@"item"]){
//
//        for(int i=0; i< [deliveryMethods count]; i++){
//            DeliveryMethod *method = [deliveryMethods objectAtIndex:i];
//            if(method.itemId == [deliveryMethodDict valueForKey:@"itemId"]){
//                NSLog(@"666");
//            }
//        }
//        if(!dublicate){
//            DeliveryMethod *method = [[DeliveryMethod alloc] init];
//            method.deliveryTimes = deliveryTimesArray;
//            method.itemId = [deliveryMethodDict valueForKey:@"itemId"];
//            [deliveryMethods addObject:method];
//            [deliveryMethodDict setObject:deliveryTimesArray forKey:@"deliveryTime"];
//
//
//            [deliveryMethods addObject:method];
//        }
        
        
        
//        deliveryTimesArray = nil;
//        deliveryMethodDict = nil;
//    }
//    else if([elementName isEqualToString:@"deliveryTime"]){
//        [deliveryTimesArray addObject:deliveryTimeDict];
//        deliveryTimeDict = nil;
//    }
//}

@end
