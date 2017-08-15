//
//  BaseWebViewViewController.h
//  FnscoDataServerApp
//
//  Created by fns on 2017/8/7.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseWebViewViewController : UIViewController
- (instancetype)initWithParams:(NSDictionary *)params; //子类vc 重写初始化

- (void)requestData;
- (void)setUpView;

@property (nonatomic, strong) WKWebView *webView;//webView

@end
