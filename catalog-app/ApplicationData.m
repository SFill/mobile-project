//
//  ApplicationData.m
//  catalog-app
//
//  Created by Admin on 09.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ApplicationData.h"
#import "CatalogXMLParser.h"
//#import "<AFNetworking/AFNetworking.h"
//#import "DeliveryMethodXMLParser.h"
#import "../MarketApi/api.m"
#import "VMCategory.h"


@interface ApplicationDataInternal : NSObject
{

}
@property (atomic, retain) NSString *token;
@property (nonatomic, retain) NSMutableArray *catalog;
@property (nonatomic, retain) NSMutableArray *cart;
@property (nonatomic, retain) NSMutableArray *favorites;
@property (nonatomic, retain) NSMutableArray *deliveryMethods;
@property (nonatomic, retain) VMLocationManager *locationManager;
@property  BOOL isAuth;


@end


@implementation ApplicationDataInternal


@end


static ApplicationDataInternal *sharedApplicationData = nil;

@implementation ApplicationData


+(ApplicationDataInternal*) getInternal
{
    @autoreleasepool {

        @synchronized(self)
        {
            if (!sharedApplicationData)
            {
                sharedApplicationData       = [[ApplicationDataInternal alloc] init];
                
                sharedApplicationData.catalog = [[NSMutableArray alloc] init];
                sharedApplicationData.cart = [[NSMutableArray alloc] init];
                sharedApplicationData.favorites = [[NSMutableArray alloc] init];
                sharedApplicationData.deliveryMethods = [[NSMutableArray alloc] init];
                sharedApplicationData.token = [[NSString alloc] init];
                sharedApplicationData.isAuth = NO;
                sharedApplicationData.locationManager = [[VMLocationManager alloc] init];
                [self setQueueForManager:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0)];
            }
        }
        return sharedApplicationData;
    }
}


+(void) loadData
{
    CatalogXMLParser *parser = [[CatalogXMLParser alloc] init];
    
    [self getInternal].catalog = [parser parse];
    
//    DeliveryMethodXMLParser *parser_for_methods = [[DeliveryMethodXMLParser alloc] init];
//
//    [self getInternal].deliveryMethods = [parser_for_methods parse];

}

+(void) setToken: (NSString*) token{
    [self getInternal].token = token;
    [self getInternal].isAuth = YES;
}

+(NSString*) getToken{
    NSString *token  =  [self getInternal].token;
    // todo Переписать методы получения товаров и категорий без токена
    return token;
}

+(NSMutableArray*) getCatalog
{
    return [self getInternal].catalog;
}

+(Product*) searchCart:(Product*)value{
    NSMutableArray *cart = [self getInternal].cart;
    Product *p = nil;
    for (int i=0; i<[cart count]; i++){
        Product *item = [cart objectAtIndex:i];
        if (item.itemId == value.itemId){
            return item;
        }
        
        
        
    }
    return p;
}


+(void) addToCart:(Product*)value
{
    NSMutableArray *cart = [self getInternal].cart;
    for (int i=0; i<[cart count]; i++){
        Product *item = [cart objectAtIndex:i];
        if (item.itemId == value.itemId){
            item.amount = [NSNumber numberWithInt: [item.amount integerValue] + [[NSNumber numberWithInt:1] integerValue]];
            return;
        }
        
        
        
    }
    [[self getInternal].cart addObject:value];
}

+(NSMutableArray*) getCart
{
    return [self getInternal].cart;
    
}

+(void) addToFavorites:(Product*)value
{
    NSMutableArray *favorites = [self getInternal].favorites;
    for (int i=0; i<[favorites count]; i++){
        Product *item = [favorites objectAtIndex:i];
        if (item.itemId == value.itemId){
            return;
        }
        
        
        
    }
    [[self getInternal].favorites addObject:value];
}

+(NSMutableArray*) getFavorites
{
    return [self getInternal].favorites;
    
}

+(NSMutableArray*) getDeliveryMethods
{
    return [self getInternal].deliveryMethods;
    
}


+(void) login:(NSString*) login withPassword: (NSString*) password  onSuccess:( void ( ^ )(NSDictionary *data) ) success onFailure:( void ( ^ )(NSString* message) ) failure{
    void (^setToken)(NSDictionary*) = ^( NSDictionary *data){
        if (
            data ==nil || success ==nil
            ) {
            return;
        }
        NSString *token = [data objectForKey:@"TOKEN"];
        [self setToken: token];
        success(data);
        
    };
    MarketApi *api = [MarketApi getInstance];
    [api loginUser:login withPassword:password onSuccess:setToken onFailure:failure];
}

+(void) registr:(NSString*) login withPassword: (NSString*) password  onSuccess:( void ( ^ )(NSDictionary *data) ) success onFailure:( void ( ^ )(NSString* message) ) failure{
    void (^setToken)(NSDictionary*) = ^( NSDictionary *data){
        if (
            data ==nil || success ==nil
            ) {
            return;
        }
        NSString *token = [data objectForKey:@"TOKEN"];
        [self setToken: token];
        success(data);
        
    };
    MarketApi *api = [MarketApi getInstance];
    [api registerUser:login withPassword:password onSuccess:setToken onFailure:failure];
}
+(void) getSubCatalogsWithID:(NSNumber*) parentID OnSuccess:(void(^)(NSDictionary* data)) success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getCatalogSections:token inPage:@30 pageNum:@1 categoryID:parentID onSuccess:success onFailure:failure];
}
+(void) getInitialCatalogSectionsOnSuccess:(void(^)(NSDictionary* data)) success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getCatalogSections:token onSuccess:success onFailure:failure];
}


+(void) getCatalogItemsWithID:(NSNumber*) categoryID withPageNum:(NSNumber*) pageNum OnSuccess:(void(^)(NSDictionary* data)) success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getCatalogItems:token inPage:@50 pageNum:pageNum categoryID:categoryID onSuccess:success onFailure:failure];
}

+(void) getTopItems:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getTopItems:token inPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
}
+(void) getFavorItems:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getFavorItems:token inPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
}
+(void) addToFav:(NSNumber*) productId OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api addToFav:token productId:productId onSuccess:success onFailure:^(AFHTTPRequestOperation * _Nullable operation) {
        [self checkAuthError:operation];
        failure(@"error");
    }];

}

+(void) searchCatalog:(NSString*) query pageNum:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    MarketApi *api = [MarketApi getInstance];
    [api searchCatalog:query inPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
   //[api searchCatalog:token inPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
}


+(void) getLastItemsForCurrentMonthWithID:(NSNumber*) categoryID
                              withPageNum:(NSNumber*) pageNum
                                   inPage: (NSNumber*) inPage
                                OnSuccess:(void(^)(NSDictionary* data)) success
                                onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    NSDate *dateTo = [[NSDate alloc] init];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateFrom = [calendar dateByAddingComponents:dateComponents toDate:dateTo options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *dateFromString = [formatter stringFromDate:dateFrom];
    NSString *dateToString = [formatter stringFromDate:dateTo];
    [api getLastItems:token
               inPage:inPage
              pageNum:pageNum
             dateFrom:dateFromString
               dateTo:dateToString
            onSuccess:success
            onFailure:failure];
}

+ (void) setQueueForManager:(dispatch_queue_t) queue{
    [[MarketApi getInstance] setQueueForManager:queue];
}
+ (void) defaultQueueForManager{
    
    [[MarketApi getInstance] defaultQueueForManager];
}


+(NSMutableArray*) getProductsFromDict:(NSDictionary*) data{
    NSArray *productItems = [[data objectForKey:@"RESULT"] objectForKey:@"ITEMS"];
    NSMutableArray *products = [[NSMutableArray alloc]init];
    for (NSDictionary *productItem in productItems) {
        Product *product = [[Product alloc] init];
        product.name = [productItem objectForKey:@"NAME"];
        product.amount = @1;
        product.itemId = [productItem objectForKey:@"ID"];
        NSNumber *price =(NSNumber*)[[productItem objectForKey:@"PRICES"] objectForKey:@"DISCOUNT_PRICE"];
        
        NSString *path = [NSString stringWithFormat:@"%@%@",@"https://www.nevkusno.ru",[productItem objectForKey:@"PREVIEW_PICTURE"]];
        
        NSURL *imgURL = [[NSURL alloc]initWithString:path];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imgURL];
        product.previewImg = [UIImage imageWithData: imageData];
        
        NSString *path2 = [NSString stringWithFormat:@"%@%@",@"https://www.nevkusno.ru",[productItem objectForKey:@"DETAIL_PICTURE"]];
        
        NSURL *imgURL2 = [[NSURL alloc]initWithString:path2];
        NSData *imageData2 = [[NSData alloc] initWithContentsOfURL:imgURL2];
        
        product.detailImg = [UIImage imageWithData:imageData2];
        
        product.price = [price stringValue];
        product.stars = [[productItem objectForKey:@"RATING"] stringValue];
        product.pDescription = [productItem objectForKey:@"DETAIL_TEXT"];
        product.stocks_quantity = (NSNumber*)[productItem objectForKey:@"STOCKS_QUANTITY"];
        product.unit = [[productItem objectForKey:@"RATIO"] objectForKey:@"RUS"];
        product.reviews = [productItem objectForKey:@"REVIEWS"];
        //todo расчитать вес товара
        //product.ves = [[productItem objectForKey:@"PRICES"] objectForKey:@"RATIO"];
        
        
        [products addObject:product];
    }
    return products;
}

+(void) registerForGeolocation{
   [[self getInternal].locationManager requestWhenInUseAuthorization];
}

+(NSString*) getGelocationStatus{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusDenied:
           //[self.locationButton setTitle: forState:UIControlStateNormal];
            return @"Геолокация запрещена";
            break;
        case kCLAuthorizationStatusNotDetermined:
            //[self.geoSwitch setOn:NO];
            
            return @"Разрешение не запрашивалось";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return @"Геолокация разрешена";
            //[self.geoSwitch setOn:YES];
//            [self.locationButton setTitle: forState:UIControlStateNormal];
            break;
        default:
            break;
            
    }
    return @"Не известно";
}

+(void) checkAuthError:(AFHTTPRequestOperation * _Nullable) operation{
    long code = [operation response].statusCode;
    NSString *message = @"Вам необходимо авторизироваться в личном кабинете";
    if (code==400) {
        [self getInternal].isAuth = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              }];
        [alert addAction:defaultAction];
        UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        [controller presentViewController:alert animated:YES completion:nil];
    }
}

+(BOOL)isAuthedUser{
    return [self getInternal].isAuth;
}


@end


