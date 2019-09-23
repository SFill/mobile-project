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
#import "../MarketApi/dto/VMDeliveryMethod.h"
#import "../MarketApi/dto/VMPriceRange.h"
#import "../MarketApi/dto/VMOrder.h"
#import "../PickPointApi/PickPointApi.h"
#import "VMCategory.h"
#import "../PickPointApi/PickPointCity.h"



@interface ApplicationDataInternal : NSObject
{

}
@property (atomic, retain) NSString *token;
@property (nonatomic, retain) NSMutableArray *catalog;
@property (nonatomic, retain) NSMutableArray *cart;
@property (nonatomic, retain) NSMutableArray *favorites;
@property (nonatomic, retain) NSMutableArray *orders;
@property (nonatomic, retain) NSMutableArray *deliveryMethods;
@property (nonatomic, retain) VMLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *pickPointCities;
@property (nonatomic, retain) NSMutableArray *pickPointCityNameFirstLetters;
@property (nonatomic, retain) NSMutableArray *pickPointCitySections;
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
                sharedApplicationData.pickPointCities = [[NSMutableArray alloc] init];
                sharedApplicationData.pickPointCitySections = [[NSMutableArray alloc] init];
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
   // [self loadCities];
    
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
            item.amount = [NSNumber numberWithInt: [item.amount intValue] + 1];
            return;
            
        }
        
    }
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"cartWasChanged"
     object:self];
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

+(void) getDeliveryMethodsWithPageNum:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    MarketApi *api = [MarketApi getInstance];
    [api getDeliveryMethodsInPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
}

+(void) createOrderWithDict:(NSDictionary*) orderDict onSuccess: (void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    MarketApi *api = [MarketApi getInstance];
    [api createOrderWithToken:[self getToken] orderDict:orderDict onSuccess:^(NSDictionary *data) {
        NSDictionary *creaOrderData = data;
        [api getUserOrders:[self getToken] inPage:@30 pageNum:@1 onSuccess:^(NSDictionary *data) {
            [self getInternal].orders = [self getOrdersFromDict:data];
            success(creaOrderData);
        } onFailure:^(NSString *message) {
            failure(message);
        }];
    } onFailure:^(AFHTTPRequestOperation * _Nullable operation) {
        NSString *message = [self checkAuthError:operation];
        failure(message);
    }];
}

+(NSMutableArray*) getDeliveryMethodsFromDict:(NSDictionary *) data{
    NSMutableArray *deliveryMethods = [[NSMutableArray alloc] init];
    NSMutableArray *items = [[data objectForKey:@"RESULT"] objectForKey:@"ITEMS"];
    if (items==nil) {
        return  deliveryMethods;
    }
    for (NSDictionary *item in items) {
        VMDeliveryMethod *deliveryMethod = [[VMDeliveryMethod alloc] init];
        deliveryMethod.Id =  [NSNumber numberWithInt:[[item objectForKey:@"ID"] intValue]];
        deliveryMethod.code = [item objectForKey:@"CODE"];
        deliveryMethod.name = [item objectForKey:@"NAME"];
        
        NSRange r;
        NSString *s = [item objectForKey:@"DESCRIPTION"];
        if (s !=(id)[NSNull null]) {
            while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                s = [s stringByReplacingCharactersInRange:r withString:@""];
            
        }
        deliveryMethod.itemDescription = s;
        deliveryMethod.currency = [item objectForKey:@"CURRENCY"];
        NSDictionary *priceTypeDict = [item objectForKey:@"PRICE"];
        if ([[priceTypeDict objectForKey:@"TYPE"] isEqualToString: VMDeliveryMethodPriceMultiple]) {
            deliveryMethod.priceType = VMDeliveryMethodPriceMultiple;
            NSArray *priceRangeItems =[priceTypeDict objectForKey:@"VALUE"];
            deliveryMethod.priceRanges =[[NSMutableArray alloc] init];
            for (NSDictionary *priceRangeItem in priceRangeItems) {
                VMPriceRange *priceRange = [[VMPriceRange alloc] init];
                priceRange.minValue = @([[priceRangeItem objectForKey:@"MIN"] integerValue]);
                priceRange.maxValue = @([[priceRangeItem objectForKey:@"MAX"] integerValue]);
                priceRange.price = @([[priceRangeItem objectForKey:@"PRICE"] integerValue]);
                [deliveryMethod.priceRanges addObject: priceRange];
            }
        }else{
            
            deliveryMethod.priceType = VMDeliveryMethodPriceSingle;
            deliveryMethod.price =@([[priceTypeDict objectForKey:@"VALUE"] integerValue]);
        }
        
        [deliveryMethods addObject:deliveryMethod];
    }
    return  deliveryMethods;
}


+(NSMutableArray*) getOrdersFromDict:(NSDictionary *) data{
    
    NSArray *orderItems = [[data objectForKey:@"RESULT"] objectForKey:@"ORDERS"];
    NSMutableArray* orders = [NSMutableArray new];
    for (NSDictionary *item in orderItems) {
        VMOrder *order = [VMOrder new];
        NSDictionary *orderProps = [item objectForKey:@"ORDER_PROPS"];
        order.userAddress = [[orderProps objectForKey:@"ADDRESS"] objectForKey:@"VALUE"];
        order.userLastName = [[orderProps objectForKey:@"SURNAME"]objectForKey:@"VALUE"];
        order.userName = [[orderProps objectForKey:@"NAME"]objectForKey:@"VALUE"];
        order.userIndex = [[orderProps objectForKey:@"INDEX"]objectForKey:@"VALUE"];
        order.userRoom = [[orderProps objectForKey:@"ROOM"]objectForKey:@"VALUE"];
        order.deliveryDate = [[orderProps objectForKey:@"DELIVERY_DATE"] objectForKey:@"VALUE"];
        order.phoneNumber = [[orderProps objectForKey:@"PHONE"] objectForKey:@"VALUE"];
        order.goodsPrice =@([[item objectForKey:@"PRICE"] integerValue]);
        [orders addObject:order];
    }
    return orders;
}

+(void) login:(NSString*) login withPassword: (NSString*) password asNewUser:(BOOL) newUser onSuccess:( void ( ^ )(NSDictionary *data) ) success onFailure:( void ( ^ )(NSString* message) ) failure{
    
    MarketApi *api = [MarketApi getInstance];
    [self getInternal].isAuth = NO;
    void (^setToken)(NSDictionary*) = ^( NSDictionary *data){
        if (
            data ==nil || success ==nil
            ) {
            return;
        }
        NSString *token = [data objectForKey:@"TOKEN"];
        [self setToken: token];
        [self loadUserDataOnSuccess:success onFailure:failure];
        
        
    };
    if (newUser) {
        [api registerUser:login withPassword:password onSuccess:setToken onFailure:failure];
    }else{
        [api loginUser:login withPassword:password onSuccess:setToken onFailure:failure];
    }
    
}
+(void) loadUserDataOnSuccess:( void ( ^ )(NSDictionary *data) ) success
                    onFailure:( void ( ^ )(NSString* message) ) failure {
     MarketApi *api = [MarketApi getInstance];
    //sync methods
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void){
        [self getFavorItemsWithPageNum:@1 inPage:@30 OnSuccess:^(NSDictionary *data) {
            [self getInternal].favorites = [self getProductsFromDict:data];
            dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
            failure(message);
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void){
        [api getUserOrders:[ApplicationData getToken] inPage:@30 pageNum:@1 onSuccess:^(NSDictionary *data) {
            [self getInternal].orders = [self getOrdersFromDict:data];
            dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
            dispatch_group_leave(group);
            failure(message);
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"user info was loaded");
        success(@{@"STATUS":@"SUCCESS",@"RESULT":@{}});
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"favWasChanged"
         object:self];
    });
}


+(void) registerUserWithFirstName:(NSString*) firstName
                         lastName:(NSString*) lastName
                            login:(NSString*) login
                         password:(NSString*) password
                        onSuccess:( void ( ^ )(NSDictionary *data) ) success
                        onFailure:( void ( ^ )(NSString* message) ) failure{
    MarketApi *api = [MarketApi getInstance];
    [api registerUserWithFirstName:firstName lastName:lastName login:login password:password onSuccess:^(NSDictionary *data) {
        if ( data ==nil || success ==nil) {
            return;
        }
        NSString *token = [data objectForKey:@"TOKEN"];
        [self setToken: token];
        success(data);
    } onFailure:failure];
}

+(void) getSubCatalogsWithID:(NSNumber*) parentID OnSuccess:(void(^)(NSDictionary* data)) success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getCatalogSections:token inPage:@150 pageNum:@1 categoryID:parentID onSuccess:success onFailure:failure];
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
+(void) getWholeSaleItemsWithPageNum:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getWholeSaleItems:token inPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
}

+(void) getFavorItemsWithPageNum:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api getFavorItems:token inPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
}
+(void) addToFav:(NSNumber*) productId OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    NSString *token = [self getToken];
    MarketApi *api = [MarketApi getInstance];
    [api addToFav:token productId:productId onSuccess:^(NSDictionary *data) {
        [self getFavorItemsWithPageNum:@1 inPage:@30 OnSuccess:^(NSDictionary *data) {
            [self getInternal].favorites = [self getProductsFromDict:data];
            success(data);
        } onFailure:^(NSString *message) {
            failure(message);
        }];
    } onFailure:^(AFHTTPRequestOperation * _Nullable operation) {
        NSString *message = [self checkAuthError:operation];
        failure(message);
    }];
    

}

+(void) searchCatalog:(NSString*) query pageNum:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure{
    MarketApi *api = [MarketApi getInstance];
    [api searchCatalog:query inPage:inPage pageNum:pageNum onSuccess:success onFailure:failure];
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
        product.amount = [NSNumber numberWithInt:1];
        product.itemId = @([[productItem objectForKey:@"ID"] integerValue]);
        NSNumber *price =(NSNumber*)[[productItem objectForKey:@"PRICES"] objectForKey:@"DISCOUNT_PRICE"];
        
        NSString *previewImgStringURL = [NSString stringWithFormat:@"%@%@",@"https://www.nevkusno.ru",[productItem objectForKey:@"PREVIEW_PICTURE"]];
        product.previewImgStringURL = previewImgStringURL;
//        NSURL *imgURL = [[NSURL alloc]initWithString:path];
//        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imgURL];
//        product.previewImg = [UIImage imageWithData: imageData];
    
        
        NSString *detailImgStringURL = [NSString stringWithFormat:@"%@%@",@"https://www.nevkusno.ru",[productItem objectForKey:@"DETAIL_PICTURE"]];
        
        product.detailImgStringURL = detailImgStringURL;
        
//        NSURL *imgURL2 = [[NSURL alloc]initWithString:path2];
//        NSData *imageData2 = [[NSData alloc] initWithContentsOfURL:imgURL2];
//
//        product.detailImg = [UIImage imageWithData:imageData2];
        if (price !=(id)[NSNull null]) {
            product.price = [price stringValue];
        }else{
            product.price = @"0";
        }
        product.stars = [[productItem objectForKey:@"RATING"] stringValue];
        product.pDescription = [productItem objectForKey:@"DETAIL_TEXT"];
        product.stocks_quantity = (NSNumber*)[productItem objectForKey:@"STOCKS_QUANTITY"];
        product.unit = [[productItem objectForKey:@"RATIO"] objectForKey:@"RUS"];
        product.reviews = [productItem objectForKey:@"REVIEWS"];
        //todo расчитать вес товара
        //product.ves = [[productItem objectForKey:@"PRICES"] objectForKey:@"RATIO"];
        
        
        [products addObject:product];
    }
//    [products sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        return
//    }]
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    
    [products sortUsingDescriptors:@[sortDescriptor]];
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

+(NSString*) checkAuthError:(AFHTTPRequestOperation * _Nullable) operation{
    long code = [operation response].statusCode;
    NSString *message = @"Вам необходимо авторизироваться в личном кабинете";
    if (code==400) {
        [self getInternal].isAuth = NO;
        return message;
    }
    NSDictionary *data = (NSDictionary*)operation.responseData;
    return [data objectForKey:@"MESSAGE"];
}

+(BOOL)isAuthedUser{
    return [self getInternal].isAuth;
}

//
//+(void) loadCities{
//  PickPointApi *api =   [PickPointApi getInstance];
//    [api getCititesOnSuccess:^(NSDictionary * _Nonnull data) {
//        NSMutableArray *pickPointCities = [self getInternal].pickPointCities;
//        NSMutableArray *pickPointCitiesFirstLetters = [[NSMutableArray alloc] init];
//        for (NSDictionary *item in [data objectForKey:@"RESULT"]) {
//            PickPointCity *city = [[PickPointCity alloc] init];
//            [city setValuesForKeysWithDictionary:item];
//            [pickPointCities addObject:city];
//            [pickPointCitiesFirstLetters addObject:[city nameFistLetter]];
//        }
//        NSSet *set = [[NSSet alloc] initWithArray:pickPointCitiesFirstLetters];
//        [self getInternal].pickPointCityNameFirstLetters = [NSMutableArray arrayWithArray:[set allObjects]];
//        [[self getInternal].pickPointCityNameFirstLetters sortUsingSelector:@selector(compare:)];
//        for (NSString *letter in [self getInternal].pickPointCityNameFirstLetters) {
//            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//                PickPointCity *city = (PickPointCity*) evaluatedObject;
//                return [letter isEqualToString:[city nameFistLetter]];
//            }];
//            NSMutableArray *filteredCityes = (NSMutableArray*)[[pickPointCities filteredArrayUsingPredicate:predicate] mutableCopy];
//            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
//                                                         ascending:YES];
//            
//            [filteredCityes sortUsingDescriptors:@[sortDescriptor]];
//            [[self getInternal].pickPointCitySections addObject:filteredCityes];
//        }
//        NSLog(@"");
//       
//    } onFailure:^(AFHTTPRequestOperation * _Nullable operation) {
//        
//    }];
//}

+(NSMutableArray*) getCities{
    return [self getInternal].pickPointCities;
}
+(NSMutableArray*) getCitySections{
    return [self getInternal].pickPointCitySections;
}

+(NSMutableArray*) getCityNameFirstLetters{
    return [self getInternal].pickPointCityNameFirstLetters;
}

+(NSMutableArray*) getOrders{
    return [self getInternal].orders;
}

+(void) cleanCart{
    [self getInternal].cart = [NSMutableArray new];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"cartWasChanged"
     object:self];
}

+(Product*) searchInFavorites:(Product*)product{
    NSMutableArray *cart = [self getInternal].favorites;
    for (int i=0; i<[cart count]; i++){
        Product *item = [cart objectAtIndex:i];
        if (item.itemId == product.itemId){
            return item;
        }
    }
    return nil;
}

+(void) logout{
    [self getInternal].token = @"";
    [self getInternal].isAuth = NO;
    [self getInternal].favorites = [NSMutableArray new];
    [self getInternal].orders = [NSMutableArray new];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"favWasChanged"
     object:self];
    
}


@end


