//
//  BaseTabBarController.m
//  FnscoDataServerApp
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "ViewController.h"


@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    [self addChildVC];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}

- (void)addChildVC {
    ViewController *leftVC      = [[ViewController alloc] init];
    leftVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:leftVC title:@"左边视图" imageName:@"" selectImageName:@""];
    BaseNavigationController *leftNav = [[BaseNavigationController alloc] initWithRootViewController:leftVC];
    
    ViewController *rightVC        = [[ViewController alloc] init];
    rightVC.view.backgroundColor   = [UIColor whiteColor];
    [self addChildViewController:rightVC title:@"右边视图" imageName:@"" selectImageName:@""];
    BaseNavigationController *rightNav = [[BaseNavigationController alloc] initWithRootViewController:rightVC];
    
    [self setViewControllers:@[leftNav,rightNav]];
}


- (void) addChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName {
  
    // 设置标题
    childVC.title = title;

    // 设置图片
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    
    // 设置普通文字
    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
    textAttributesDict[NSForegroundColorAttributeName] = RGB(128, 128, 128);
    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:textAttributesDict forState:UIControlStateNormal];
    
    // 设置选中文字属性
    NSMutableDictionary *selectedTextAttrDict = [NSMutableDictionary dictionary];
    selectedTextAttrDict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectedTextAttrDict[NSForegroundColorAttributeName] = RGB(53, 149, 255);
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttrDict forState:UIControlStateSelected];
    
    // 设置文字的
    childVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}
@end
