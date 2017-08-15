//
//  BaseViewController.h
//  FnscoDataServerApp
//
//  Created by fns on 2017/6/22.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (instancetype)initWithParams:(NSDictionary *)params; //子类vc 重写初始化


- (void)requestData;
- (void)setUpView;
- (void)config;//配置信息
- (void)pushToViewControllerWithClassName:(NSString *)className;//页面跳转
//错误页面设置
- (void)showPlaceView:(UIView *)view imageName:(NSString *)imageName title:(NSString *)title;
- (void)showPlaceView:(UIView *)view imageName:(NSString *)imageName title:(NSString *)title btnTitle:(NSString *)btnTitle;
- (void)removePlaceView;

/**
 *  如果cell一页未用完，隐藏下面的线
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView;

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign) BOOL openKeyboardScroll;//开启键盘滑动tableview功能
@property (nonatomic, copy) void (^ErrorViewBlock)(void);


//注册路由
- (void)registerJLRouter;
//- (void)enterBlock:(void(^)(id obj))EnterBlock;//进入vc 的block 用来传值
@property (nonatomic, copy) void(^backBlock)(id obj);//退出VC的block

- (void)backButtonClick;
@end
