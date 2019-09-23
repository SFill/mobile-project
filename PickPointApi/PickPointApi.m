//
//  PickPointApi.m
//  nevkusno
//
//  Created by Никита  on 25.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "PickPointApi.h"

@implementation PickPointApi

NSString *const HOST_PATH_PICK_POINT = @"https://e-solution.pickpoint.ru/apitest";
static PickPointApi *api = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baseURL = [NSURL URLWithString:HOST_PATH_PICK_POINT];
        self.manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}


- (void) setQueueForManager:(dispatch_queue_t) queue{
    _manager.completionQueue = queue;
}
- (void) defaultQueueForManager{
    _manager.completionQueue = nil;
}

+ (PickPointApi *) getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^
                  {
                      api = [[PickPointApi alloc] init];
                  });
    return api;
}

-(void) getCititesOnSuccess:( void ( ^ )(NSDictionary *data) ) success
                  onFailure: ( void ( ^ )(AFHTTPRequestOperation * _Nullable operation) )  failure{
    NSString *methodPath = [NSString stringWithFormat:@"%@/%@",HOST_PATH_PICK_POINT,@"citylist"];
    
    
    [self.manager GET:methodPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = @{@"RESULT":(NSArray*)responseObject};
        success(responseData);
        //[self checkSuccessResponse:responseData onSuccess:success orFailure:nil];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation);
    }];
}

@end
