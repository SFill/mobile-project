//
//  PickPointApi.h
//  nevkusno
//
//  Created by Никита  on 25.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface PickPointApi : NSObject
@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
+(PickPointApi*) getInstance;
-(void) getCititesOnSuccess:( void ( ^ )(NSDictionary *data) ) success
                  onFailure: ( void ( ^ )(AFHTTPRequestOperation * _Nullable operation) )  failure;
@end

NS_ASSUME_NONNULL_END
