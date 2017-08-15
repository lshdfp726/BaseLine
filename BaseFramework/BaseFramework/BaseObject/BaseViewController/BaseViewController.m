//
//  BaseViewController.m
//  FnscoDataServerApp
//
//  Created by fns on 2017/6/22.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import "BaseViewController.h"
#import "JLRouterManager.h"
#import "ModalDefineAnimationTransition.h"
//#import "LoginViewController.H"
#import "BaseNavigationController.h"
#import "PlaceholderView.h"


@interface BaseViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) PlaceholderView *errorV;
@property (nonatomic, strong) ModalDefineAnimationTransition *modalAnimationManager;
@end

@implementation BaseViewController

- (instancetype)initWithParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   // Do any additional setup after loading the view.
    [self config];
 
    //注册路由
    [self registerJLRouter];
    
    //模态视图动画自定义
//    [self modalAnimation];
}


#pragma mark - 页面跳转代码
- (void)pushToViewControllerWithClassName:(NSString *)className {
    RouterModel *model = [[RouterModel alloc] initWithScheme:[SchemeManager acchieveSchemeCharWithIndex:0] className:@[className] identify:RouterParamsValue];
    [JLRouterManager openWithValueModel:model];
}


#pragma mark - 配置信息
- (void)config {
    self.view.backgroundColor   = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //增加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    tap.cancelsTouchesInView =  NO;
    [self.view addGestureRecognizer:tap];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [[UIButton alloc] init];
        [backButton setImage:[UIImage imageNamed:@"Common_BackArrow"] forState:UIControlStateNormal];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        backButton.frame = CGRectMake(0, 0, 20.0, 20.0);
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
}


- (void)modalAnimation {
    _modalAnimationManager = [[ModalDefineAnimationTransition alloc] init];
    [_modalAnimationManager lsh_getInteractiveWithGestureRecognizer:[[UIPanGestureRecognizer alloc] init] AddToView:self.view InteractiveBlock:^(UIPercentDrivenInteractiveTransition *interActive, UIGestureRecognizer *reg) {
        UIPanGestureRecognizer *panGes = (UIPanGestureRecognizer *)reg;
        CGPoint point = [panGes translationInView:reg.view];
        NSLog(@"手指在x轴上平移坐标%f",point.x);
        if (point.x > 0) {
            CGFloat per = point.x/reg.view.frame.size.width;
            per = MIN(1.0, MAX(0.0, per));
            if (panGes.state == UIGestureRecognizerStateBegan) {
                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"开始了");
            } else if (panGes.state == UIGestureRecognizerStateChanged) {
                [interActive updateInteractiveTransition:per];
            } else if (panGes.state == UIGestureRecognizerStateEnded || panGes.state == UIGestureRecognizerStateCancelled) {
                if (per > 0.5) {
                    [interActive finishInteractiveTransition];
                } else {
                    [interActive cancelInteractiveTransition];
                }
            }
        }
    }];
    self.transitioningDelegate = _modalAnimationManager;
}


#pragma mark - 数据请求
- (void)requestData {
}


#pragma mark - 设置UI
- (void)setUpView {
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.delegate   = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView setBackgroundColor:commonGrayBackgroundColor];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.myTableView = tableView;
}


- (void)endEdit {
    [self.view endEditing:YES];
}


#pragma mark ------ keyboardNotification
//隐藏键盘
- (void)keyboardWillHide:(NSNotification *)notification {
    
    [UIView animateWithDuration:0.3 animations:^{
        //将contentInset的值设回原来的默认值
        UIEdgeInsets e = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.myTableView setContentInset:e];
    }];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark - 显示／隐藏
- (void)showPlaceView:(UIView *)view imageName:(NSString *)imageName title:(NSString *)title {
    [self.view setNeedsLayout];//必须加上去
    WS(weakSelf);
    self.errorV.refreshDataAction = ^ {
        [weakSelf requestData];
    };
    [self.errorV setPlaceTitle:title];
    [self.errorV setPlaceImage:[UIImage imageNamed:imageName]];
    [self.errorV addToSuperView:view];
    [self.errorV setFrame:CGRectMake(0, 0, view.width, view.height)];
    self.errorV.BottomBtnAction = ^{//底部按钮动作
        if (weakSelf.ErrorViewBlock) {//底部按钮动作传出去
            weakSelf.ErrorViewBlock();
        }
    };
}


- (void)showPlaceView:(UIView *)view imageName:(NSString *)imageName title:(NSString *)title btnTitle:(NSString *)btnTitle {
    if (btnTitle == nil) {
        [self.errorV hiddenBottomBtn];
    } else {
        [self.errorV showBottomBtn];
    }
    
    [self.errorV setPlaceBtnTitle:btnTitle];
    [self showPlaceView:view imageName:imageName title:title];
}


- (void)removePlaceView {
    for (UIView *v in self.myTableView.subviews) {//移除站位view
        if ([v isKindOfClass:[PlaceholderView class]]) {
            [v removeFromSuperview];
             self.errorV = nil;
        }
    }
}


- (PlaceholderView *)errorV {
    if (!_errorV) {
        _errorV = [[PlaceholderView alloc] init];
    }
    return _errorV;
}

/**
 *  如果cell一页未用完，隐藏下面的线
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


#pragma mark - 注册路由
- (void)registerJLRouter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RouterModel *model = [[RouterModel alloc] initWithScheme:[SchemeManager acchieveSchemeCharWithIndex:0] className:@[@"vcName"] identify:RouterParamsKey];
        [[JLRouterManager routerManagerWithKeyModel:model] registerJLRouterWithParams:YES completion:nil destionVC:^(BaseViewController *vc) {
          
        }];
    });
}


#pragma mark - lifeRecycle 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}


//显示键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度
    CGFloat height = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    UIEdgeInsets e = UIEdgeInsetsMake(0, 0, height, 0);
    [self.myTableView setContentInset:e];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


//布局子控件
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


#pragma mark - tableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


#pragma mark 返回按钮动作
- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
