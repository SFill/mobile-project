//
//  api.m
//  Приложение для кондитера
//
//  Created by Никита  on 10.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Pods/AFNetworking/AFNetworking/AFNetworking.h"



@interface MarketApi : NSObject

FOUNDATION_EXPORT NSString *const HOST_PATH;
FOUNDATION_EXPORT NSString *const SUCCESS_STATUS;
FOUNDATION_EXPORT NSString *const SUCCES_DATA;
FOUNDATION_EXPORT NSString *const ERROR_STATUS;
FOUNDATION_EXPORT NSString *const ERROR_DATA;
FOUNDATION_EXPORT NSString *const API_EXCEPTION_NAME;

+ (MarketApi *) getInstance;
-(void) loginUser:(NSString*) login
          withPassword: (NSString*) password
             onSuccess: ( void ( ^ )(NSDictionary *data) ) success
             onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) registerUser:(NSString*) login
     withPassword: (NSString*) password
        onSuccess: ( void ( ^ )(NSDictionary *data) ) success
        onFailure: ( void ( ^ )(NSString *message) )  failure;

-(void) registerUserWithFirstName:(NSString*) firstName
                         lastName:(NSString*) lastName
                            login:(NSString*) login
                         password:(NSString*) password
                        onSuccess: ( void ( ^ )(NSDictionary *data) ) success
                        onFailure: ( void ( ^ )(NSString *message) )  failure;

-(void) getCatalogSections:(NSString*) token
           onSuccess: ( void ( ^ )(NSDictionary *data) ) success
           onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) getCatalogSections:(NSString*) token
                    inPage: (NSNumber*) inPage
                   pageNum: (NSNumber*) pageNum
                categoryID:(NSNumber*) categoryID
                 onSuccess: ( void ( ^ )(NSDictionary *data) ) success
                 onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) getCatalogItems:(NSString*) token
                 inPage: (NSNumber*) inPage
                pageNum: (NSNumber*) pageNum
             categoryID:(NSNumber*) categoryID
              onSuccess: ( void ( ^ )(NSDictionary *data) ) success
              onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) getTopItems:(NSString*) token
             inPage: (NSNumber*) inPage
            pageNum: (NSNumber*) pageNum
          onSuccess: ( void ( ^ )(NSDictionary *data) ) success
          onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) getWholeSaleItems:(NSString*) token
                 inPage: (NSNumber*) inPage
                pageNum: (NSNumber*) pageNum
              onSuccess: ( void ( ^ )(NSDictionary *data) ) success
              onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) getLastItems:(NSString*) token
              inPage: (NSNumber*) inPage
             pageNum: (NSNumber*) pageNum
            dateFrom:(NSString*) dateFrom
              dateTo:(NSString*) dateTo
           onSuccess: ( void ( ^ )(NSDictionary *data) ) success
           onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) getFavorItems:(NSString*) token
               inPage: (NSNumber*) inPage
              pageNum: (NSNumber*) pageNum
            onSuccess: ( void ( ^ )(NSDictionary *data) ) success
            onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) searchCatalog:(NSString*) token
               inPage: (NSNumber*) inPage
              pageNum: (NSNumber*) pageNum
            onSuccess: ( void ( ^ )(NSDictionary *data) ) success
            onFailure: ( void ( ^ )(NSString *message) )  failure;
-(void) addToFav:(NSString*) token
       productId:(NSNumber*) productId
       onSuccess: ( void ( ^ )(NSDictionary *data) ) success
       onFailure: ( void ( ^ )(AFHTTPRequestOperation * _Nullable operation) )  failure;
-(void) getDeliveryMethodsInPage:(NSNumber*) inPage
                         pageNum: (NSNumber*) pageNum
                       onSuccess: ( void ( ^ )(NSDictionary *data) ) success
                       onFailure: ( void ( ^ )(NSString *message) )  failure;
 -(void) createOrderWithToken:(NSString*) token
           orderDict:(NSDictionary*) orderDict
           onSuccess:( void ( ^ )(NSDictionary *data) ) success
                    onFailure: ( void ( ^ )(AFHTTPRequestOperation * _Nullable operation) )  failure;
-(void) getUserOrders:(NSString*) token
           inPage: (NSNumber*) inPage
          pageNum: (NSNumber*) pageNum
        onSuccess: ( void ( ^ )(NSDictionary *data) ) success
            onFailure: ( void ( ^ )(NSString *message) )  failure;
@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@end

@implementation MarketApi

NSString *const HOST_PATH = @"https://www.nevkusno.ru/bitrix/API";
NSString *const SUCCESS_STATUS = @"SUCCESS";
NSString *const SUCCES_DATA = @"RESULT";
NSString *const ERROR_STATUS = @"ERROR";
NSString *const ERROR_DATA = @"MESSAGE";
NSString *const API_EXCEPTION_NAME = @"ApiException";
static MarketApi *api = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseURL = [NSURL URLWithString:HOST_PATH];
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}


- (void) setQueueForManager:(dispatch_queue_t) queue{
    _manager.completionQueue = queue;
}
- (void) defaultQueueForManager{
    _manager.completionQueue = nil;
}

+ (MarketApi *) getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^
    {
        api = [[MarketApi alloc] init];
    });
    return api;
}
NSOperation *searchOperation;
-(void) addToFav:(NSString*) token productId:(NSNumber*) productId onSuccess: ( void ( ^ )(NSDictionary *data) ) success onFailure: ( void ( ^ )(AFHTTPRequestOperation * _Nullable operation) )  failure{
    [searchOperation cancel];
    NSDictionary *dict = @{@"id":productId,@"token":token};
    NSString *catalogItemsPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"updateUserFavList"];
    
    
    [_manager POST:catalogItemsPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:nil];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation);
        // exit(0);
    }];
}
 -(void) createOrderWithToken:(NSString*) token orderDict:(NSDictionary*) orderDict onSuccess:( void ( ^ )(NSDictionary *data) ) success onFailure: ( void ( ^ )(AFHTTPRequestOperation * _Nullable operation) )  failure{
    [searchOperation cancel];
    NSDictionary *dict = @{@"order":orderDict,@"token":token};
    NSString *catalogItemsPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"createOrder"];
    
    
    [_manager POST:catalogItemsPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:nil];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation);
        // exit(0);
    }];
}

-(void) getUserOrders:(NSString*) token
             inPage: (NSNumber*) inPage
            pageNum: (NSNumber*) pageNum
          onSuccess: ( void ( ^ )(NSDictionary *data) ) success
          onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"token":token,@"inPage":inPage,@"pageNum":pageNum};
    NSString *methodPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getUserOrders"];
    
    
    [_manager GET:methodPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
    }];
}


-(void) getDeliveryMethodsInPage:(NSNumber*) inPage
              pageNum: (NSNumber*) pageNum
            onSuccess: ( void ( ^ )(NSDictionary *data) ) success
            onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"inPage":inPage,@"pageNum":pageNum};
    NSString *methodPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getDeliveryMethods"];
    
    
    [_manager GET:methodPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
        //exit(0);
    }];
}


-(void) searchCatalog:(NSString*) query
               inPage: (NSNumber*) inPage
              pageNum: (NSNumber*) pageNum
            onSuccess: ( void ( ^ )(NSDictionary *data) ) success
            onFailure: ( void ( ^ )(NSString *message) )  failure{
    [searchOperation cancel];
    NSDictionary *dict = @{@"query":query,@"active":@"Y",@"inPage":inPage,@"pageNum":pageNum};
    NSString *catalogItemsPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"searchCatalog"];
    
    
    searchOperation = [_manager POST:catalogItemsPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(@"error");
       // exit(0);
    }];
}

-(void) getFavorItems:(NSString*) token
              inPage: (NSNumber*) inPage
             pageNum: (NSNumber*) pageNum
           onSuccess: ( void ( ^ )(NSDictionary *data) ) success
           onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"token":token,@"active":@"Y",@"inPage":inPage,@"pageNum":pageNum};
    NSString *catalogItemsPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getUserFavList"];
    
    
    [_manager GET:catalogItemsPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
        //exit(0);
    }];
}


-(void) getLastItems:(NSString*) token
             inPage: (NSNumber*) inPage
            pageNum: (NSNumber*) pageNum
            dateFrom:(NSString*) dateFrom
            dateTo:(NSString*) dateTo
          onSuccess: ( void ( ^ )(NSDictionary *data) ) success
          onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"token":token,@"active":@"Y",@"inPage":inPage,@"pageNum":pageNum,@"dateFrom":dateFrom,@"dateTo":dateTo};
    NSString *catalogItemsPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getCatalogItems"];
    
    
    [_manager GET:catalogItemsPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
    }];
}

-(void) getTopItems:(NSString*) token
                 inPage: (NSNumber*) inPage
                pageNum: (NSNumber*) pageNum
              onSuccess: ( void ( ^ )(NSDictionary *data) ) success
              onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"token":token,@"active":@"Y",@"inPage":inPage,@"pageNum":pageNum};
    NSString *topItemsPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getTopItems"];
    
    
    [_manager GET:topItemsPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
    }];
}


-(void) getCatalogItems:(NSString*) token
                 inPage: (NSNumber*) inPage
                pageNum: (NSNumber*) pageNum
             categoryID:(NSNumber*) categoryID
              onSuccess: ( void ( ^ )(NSDictionary *data) ) success
              onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"token":token,@"active":@"Y",@"inPage":inPage,@"categoryID":categoryID,@"pageNum":pageNum};
    NSString *authPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getCatalogItems"];
    
    
    [_manager GET:authPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
    }];
}
-(void) getWholeSaleItems:(NSString*) token
                   inPage: (NSNumber*) inPage
                  pageNum: (NSNumber*) pageNum
                onSuccess: ( void ( ^ )(NSDictionary *data) ) success
                onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"token":token,@"active":@"Y",@"inPage":inPage,@"pageNum":pageNum};
    NSString *authPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getWholesaleItems"];
    
    
    [_manager GET:authPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
    }];
}


-(void) getCatalogSections:(NSString *)token onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSString *))failure{
    NSDictionary *dict = @{@"token":token,@"active":@"Y"};
    NSString *authPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getCatalogSections"];
    
    
    [_manager GET:authPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
    }];
}



-(void) getCatalogSections:(NSString*) token
                    inPage: (NSNumber*) inPage
                   pageNum: (NSNumber*) pageNum
                categoryID:(NSNumber*) categoryID
                 onSuccess: ( void ( ^ )(NSDictionary *data) ) success
                 onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSDictionary *dict = @{@"token":token,@"active":@"Y",@"inPage":inPage,@"categoryID":categoryID,@"pageNum":pageNum};
    NSString *authPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"getCatalogSections"];
    
    
    [_manager GET:authPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error");
        failure(@"Error");
    }];
}


- (void) loginUser:(NSString*) login
           withPassword: (NSString*) password
              onSuccess: ( void ( ^ )(NSDictionary *data) ) success
              onFailure: ( void ( ^ )(NSString *message) )  failure
{
    NSDictionary *dict = @{@"login":login,@"password":password};
    NSString *authPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"authorization"];
    [_manager POST:authPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
       // TODO test
        NSLog(@"Error");
        NSDictionary *data = (NSDictionary*)operation.responseData;
        failure([data objectForKey:@"MESSAGE"]);
    }];
    
}

- (void) registerUser:(NSString*) login
      withPassword: (NSString*) password
         onSuccess: ( void ( ^ )(NSDictionary *data) ) success
         onFailure: ( void ( ^ )(NSString *message) )  failure
{
    NSString *authPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"registration"];
    NSDictionary *dict = @{@"login":login,@"password":password};
    [_manager POST:authPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        // TODO test
        NSLog(@"Error");
        NSDictionary *data = (NSDictionary*)operation.responseData;
        failure([data objectForKey:@"MESSAGE"]);
    }];
}
-(void) registerUserWithFirstName:(NSString*) firstName
                         lastName:(NSString*) lastName
                            login:(NSString*) login
                         password:(NSString*) password
                        onSuccess: ( void ( ^ )(NSDictionary *data) ) success
                        onFailure: ( void ( ^ )(NSString *message) )  failure{
    NSString *authPath = [NSString stringWithFormat:@"%@/%@/",HOST_PATH,@"registration"];
    NSDictionary *dict = @{@"login":login,@"password":password,@"name":firstName,@"lastName":lastName};
    [_manager POST:authPath parameters:[self wrapDict:dict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        [self checkSuccessResponse:responseData onSuccess:success orFailure:failure];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        // TODO test
        NSLog(@"register Error");
        NSDictionary *data = (NSDictionary*)operation.responseData;
        failure([data objectForKey:@"MESSAGE"]);
    }];
}



- (NSData *) dictToSendData:(NSDictionary*)dict{
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:dataJson encoding:NSUTF8StringEncoding];
    NSString *sendString = [NSString stringWithFormat:@"input=%@",jsonString];
    
    return  [sendString dataUsingEncoding:NSUTF8StringEncoding];
    
}


- (NSDictionary *) wrapDict:(NSDictionary*)dict{
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:dataJson encoding:NSUTF8StringEncoding];
    NSDictionary *sendDict = @{ @"input":jsonString};
    
    return  sendDict;
    
}


- (NSDictionary*) DataJsonToDict:(NSData*) data {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    return dict;
}
-(void) checkSuccessResponse: (NSDictionary*) response onSuccess:( void ( ^ )(NSDictionary *data) ) success
                           orFailure: ( void ( ^ )(NSString *message) )  failure{
    if (response ==nil) {
        return;
    }
    
    if ([[response objectForKey:@"STATUS"] isEqualToString: ERROR_STATUS]) {
        if(failure){
            failure([response objectForKey:ERROR_DATA]);
        }
        return;
        
    }
    if(success){
        success(response);
    }
}


@end
