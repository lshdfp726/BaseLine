//
//  BaseNavigationController.m
//  FnscoDataServerApp
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationBarTheme];
    
    [self setUpNavigationBarBackgroundColor];
    
    [self setUpBarButtonItem];
}

/**
 *  设置UINavigationBarTheme的主题
 */
- (void)setUpNavigationBarTheme {
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowOffset:CGSizeZero];
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
    
    [appearance setBarTintColor:[UIColor whiteColor]];
    [appearance setTranslucent:NO];
}


//设置导航栏的背景颜色
- (void)setUpNavigationBarBackgroundColor {
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
}


- (void)setUpBarButtonItem {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = RGB(51, 51, 51);
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
