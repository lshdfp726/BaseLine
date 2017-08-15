//
//  JLRouterManager.m
//  UsualTest
//
//  Created by fns on 2017/6/21.
//  Copyright © 2017年 fns. All rights reserved.
//

#import "JLRouterManager.h"
#import "BaseViewController.h"
#import "JLRoutes.h"


#define PUSHMETHOD @"pushMethod"
@interface JLRouterManager () {
    RouterModel *_keyModel;
    RouterModel *_valueModel;
    
}

@end

@implementation JLRouterManager

+ (instancetype)routerManagerWithKeyModel:(RouterModel *)model {
    return [[[self class] alloc] initWithKeyModel:model];
}


- (instancetype)initWithKeyModel:(RouterModel *)model {
    self = [super init];
    if (self) {
        _keyModel = model;
    }
    return self;
}


+ (instancetype)routerManager {
    return [[[self class] alloc] initWithKeyModel:nil];
}


- (void)registerJLRouterWithParams:(BOOL)hasParams completion:(void (^ __nullable)(void))completion destionVC:(void (^)(BaseViewController *))destionVCBlock {
    if (_keyModel.identify == RouterParamsValue) {
        NSLog(@"keyModel 设置成了ValuelModel!");
        return;
    }
    
    JLRoutes *routes = [JLRoutes routesForScheme:_keyModel.scheme];
    [routes addRoute:_keyModel.pathUrl handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *vcName = parameters[_keyModel.className[0]];
        Class class = NSClassFromString(vcName);
        BaseViewController *destionVC  = nil;
        if (hasParams) {
            destionVC = [[class alloc] initWithParams:parameters];
        } else {
            destionVC = [[class alloc] init];
        }
        
        if (!destionVC) {
            NSLog(@"控制器名称不对，生成不了对应的VC!请检查传入的参数");
            return NO;
        }
        
        //获取当前VC 传出去
        if (destionVCBlock) {
            destionVCBlock(destionVC);
        }
        //寻找当前窗口的VC
        BaseViewController *currentVC = (BaseViewController *)[UIViewController currentViewController];
        if (!currentVC) {
            NSLog(@"当前窗口没有对应的控制器!");
            return NO;
        }
        
        if ([[parameters allKeys] containsObject:PUSHMETHOD]) {
            NSString * pushMethod = parameters[PUSHMETHOD];//约定好的字段！
            if ([pushMethod integerValue] == Push) {
                [currentVC.navigationController pushViewController:destionVC animated:YES];
            } else if ([pushMethod integerValue] == Present) {
//                currentVC.definesPresentationContext = YES;//被推出的模态视图真正的由self 展示，如果为NO，那么被推出的模态视图由跟视图tabbar展示，被推出的模态视图要设置modalPresentationStyle = UIModalPresentationCurrentContext;
//                destionVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [currentVC presentViewController:destionVC animated:YES completion:completion];
            }
        } else {
                [currentVC.navigationController pushViewController:destionVC animated:YES];
        }
       
        return YES;
    }];
}


+ (void)openWithValueModel:(RouterModel *)model {
    NSString *urlStr = model.pathUrl;
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//允许scheme url 拼接参数！
    if (([[[UIDevice currentDevice] systemVersion] floatValue] < 10)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }

}


/**oc 对象转成json对象
 obj 必须为字典或者数组字典
 */
+ (NSString *)OCObjToJsonObj:(id)obj {
    if (!([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]])) {
        NSLog(@"obj 参数不是指定类型");
        return @"";
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        for (NSInteger i = 0; i < [(NSArray *)obj count]; i ++) {
            if (![obj[i] isKindOfClass:[NSDictionary class]]) {
                NSLog(@"obj数组内部不是字典，model转字典");
                return @"";
            }
        }
    }
    
    NSError *error = nil;
    NSData *data   =  [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return dataStr;
}


+ (id)jsonObjToOCObj:(NSString *)json {
    NSError *error = nil;
    id obj = nil;
       obj = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"json解析成oc错误:%@",error);
        return nil;
    }
    return obj;
}
@end
