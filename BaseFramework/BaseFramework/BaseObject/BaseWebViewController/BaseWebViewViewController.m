//
//  BaseWebViewViewController.m
//  FnscoDataServerApp
//
//  Created by fns on 2017/8/7.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import "BaseWebViewViewController.h"
#import <WebKit/WebKit.h>

#define progressH 1.5f

@interface BaseWebViewViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (weak, nonatomic) CALayer *progresslayer;
@end

@implementation BaseWebViewViewController

- (instancetype)initWithParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)setUpView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 创建UserContentController（提供JavaScript向webView发送消息的方法）
    WKUserContentController* userContent = [[WKUserContentController alloc] init];
    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    [userContent addScriptMessageHandler:self name:@"param"];
    // 将UserConttentController设置到配置文件
    config.userContentController = userContent;
    // 高端的自定义配置创建WKWebView
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    //添加属性监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), progressH)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, progressH);
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}


- (void)requestData {
   
}


#pragma mark - webView代理
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
//    if ([webView.URL.query isEqualToString:@"back"]) {
//        //添加导航栏按钮
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(8, 11.5, 13, 21);
//        btn.contentMode = UIViewContentModeCenter;
//        btn.clipsToBounds = YES;
//        [btn setImage:[UIImage imageNamed:@"Common_BackArrow"] forState:UIControlStateNormal];
//        [btn obsersverEvents:UIControlEventTouchUpInside withBlock:^(id obj) {
//            if ([self.webView canGoBack]) {
//                [self.webView goBack];
//            }
//        }];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        NSLog(@"%@",webView.URL);
//        self.tabBarController.tabBar.hidden = YES;
//        
//        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.equalTo(self.view);
//            make.bottom.equalTo(self.view).offset(self.tabBarController.tabBar.height);
//        }];
//        
//        self.navigationItem.rightBarButtonItem = nil;
//    } else {
//        self.tabBarController.tabBar.hidden = NO;
//        self.navigationItem.leftBarButtonItem = nil;
//        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//        }];
//        self.navigationItem.rightBarButtonItem = nil;
//    }
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
//    self.navigationItem.title = self.webView.backForwardList.currentItem.title;
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    JKLog(@"message.name==%@", message.name);
//    JKLog(@"message.body==%@", message.body);
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:message.body]];
}


#pragma mark - 监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"%@", change);
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], progressH);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, progressH);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
