//
//  AppDelegate+Service.m
//  FnscoDataServerApp
//
//  Created by fns on 2017/6/18.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import "AppDelegate+Service.h"
#import "BaseTabBarController.h"

@implementation AppDelegate (Service)

+ (BOOL)applicationWithService:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置根控制器
    [self setRootViewController];
    return YES;
}


#pragma mark - 设置根控制器
+ (void)setRootViewController {
    UIWindow *keyWindow = [[UIApplication sharedApplication] delegate].window;
    BaseTabBarController *tabBarVC = [[BaseTabBarController alloc] init];
    keyWindow.rootViewController = tabBarVC;
    [keyWindow makeKeyAndVisible];
}


@end
