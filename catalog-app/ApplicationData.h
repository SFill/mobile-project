//
//  ApplicationData.h
//  catalog-app
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "../Pods/AFNetworking/AFNetworking/AFNetworking.h"
#import "../VMLocationManager.h"

@interface ApplicationData : NSObject

+(void) loadData;
+(NSMutableArray*) getCatalog;
+(NSMutableArray*) getFavorites;

+(void) addToCart:(Product*)value;
+(void) addToFavorites:(Product*)value;
+(NSMutableArray*) getCart;
+(NSMutableArray*) getDeliveryMethods;
+(Product*) searchCart: (Product*) value;
+(void) login:(NSString*) login withPassword: (NSString*) password  onSuccess:( void ( ^ )(NSDictionary *data) ) success onFailure:( void ( ^ )(NSString *message) ) failure;
+(void) registr:(NSString*) login withPassword: (NSString*) password  onSuccess:( void ( ^ )(NSDictionary *data) ) success onFailure:( void ( ^ )(NSString *message) ) failure;
+(void) getInitialCatalogSectionsOnSuccess:(void(^)(NSDictionary* data)) success onFailure:(void(^)(NSString* message)) failure;
+(void) getSubCatalogsWithID:(NSNumber*) parentID OnSuccess:(void(^)(NSDictionary* data)) success onFailure:(void(^)(NSString* message)) failure;
+(void) getCatalogItemsWithID:(NSNumber*) categoryID withPageNum:(NSNumber*) pageNum OnSuccess:(void(^)(NSDictionary* data)) success onFailure:(void(^)(NSString* message)) failure;
+(void) getCatalogItemsWithID:(NSNumber*) categoryID withPageNum:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure;
+(void) getTopItems:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure;
+(void) getLastItemsForCurrentMonthWithID:(NSNumber*) categoryID
                              withPageNum:(NSNumber*) pageNum
                                   inPage: (NSNumber*) inPage
                                OnSuccess:(void(^)(NSDictionary* data)) success
                                onFailure:(void(^)(NSString* message)) failure;
+(void) getFavorItems:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure;
+(void) searchCatalog:(NSString*) query pageNum:(NSNumber*) pageNum inPage: (NSNumber*) inPage OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure;
+(void) addToFav:(NSNumber*) productId OnSuccess:(void(^)(NSDictionary* data))  success onFailure:(void(^)(NSString* message)) failure;
+ (void) setQueueForManager:(dispatch_queue_t) queue;
+ (void) defaultQueueForManager;
+(NSMutableArray*) getProductsFromDict:(NSDictionary*) data;
+(void) registerForGeolocation;
+(NSString*) getGelocationStatus;
+(BOOL)isAuthedUser;
+(NSMutableArray*) getCities;
+(NSMutableArray*) getCitySections;
+(NSMutableArray*) getCityNameFirstLetters;

@end
