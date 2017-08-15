//
//  AppDelegate+Service.h
//  FnscoDataServerApp
//
//  Created by fns on 2017/6/18.
//  Copyright © 2017年 fnsco. All rights reserved.
//


#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate (Service) <UNUserNotificationCenterDelegate>
+ (BOOL)applicationWithService:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


@end
