//
//  ApplicationData2.m
//  catalog-app
//
//  Created by Admin on 09.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ApplicationData2.h"
#import "CategoryXMLParser.h"



@interface ApplicationData2Internal : NSObject
{

}
@property (nonatomic, retain) NSMutableArray *category;
@property (nonatomic, retain) NSMutableArray *cart;


@end


@implementation ApplicationData2Internal


@end


static ApplicationData2Internal *sharedApplicationData2 = nil;

@implementation ApplicationData2

+(ApplicationData2Internal*) getInternal
{
    @autoreleasepool {

        @synchronized(self)
        {
            if (!sharedApplicationData2)
            {
                sharedApplicationData2       = [[ApplicationData2Internal alloc] init];
                
                sharedApplicationData2.category = [[NSMutableArray alloc] init];
                sharedApplicationData2.cart = [[NSMutableArray alloc] init];
                
            }
        }

        return sharedApplicationData2;
    }
}


+(void) loadData2
{
    CategoryXMLParser *parser = [[CategoryXMLParser alloc] init];
    
    [self getInternal].category = [parser parse];
}

+(NSMutableArray*) getCategory
{
    return [self getInternal].category;
}

+(void) addToCart:(VMCategory*)value
{
    return [[self getInternal].cart addObject:value];
}

+(NSMutableArray*) getCart
{
    return [self getInternal].cart;
}




@end


