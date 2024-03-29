//
//  AppDelegate.m
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//
#import "AppDelegate.h"
#import "ApplicationData.h"
#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"

@interface AppDelegate (){
    GCDWebServer* _webServer;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ApplicationData loadData];
    [NSUserDefaults.standardUserDefaults setObject:@[@"RU"] forKey:@"AppleLanguages"];
    [self registerForRemoteNotifications];
    [ApplicationData registerForGeolocation];
    
    _webServer = [[GCDWebServer alloc] init];
    
    // Add a handler to respond to GET requests on any URL
    NSString* websitePath = [[NSBundle mainBundle] pathForResource:@"ModelPage" ofType:@".html"];
    [_webServer addHandlerForMethod:@"GET"
                          pathRegex:@"/pickpoint/"
                       requestClass:[GCDWebServerRequest class]
                       processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                                  
                                  return [GCDWebServerDataResponse responseWithHTMLTemplate:websitePath variables:@{}];
                                  
                              }];
    
    // Start server on port 8080
    [_webServer startWithPort:8080 bonjourName:nil];
    
    return YES;
}


- (void)registerForRemoteNotifications {
//    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        center.delegate = self;
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
//            if(!error){
//                [[UIApplication sharedApplication] registerForRemoteNotifications];
//            }
//        }];
//    }
//    else {
//        // Code for old versions
//    }
}



//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
//-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
//    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
//    completionHandler();
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
