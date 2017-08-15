//
//  JLRouterManager.h
//  UsualTest
//
//  Created by fns on 2017/6/21.
//  Copyright © 2017年 fns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RouterModel.h"
#import "BaseViewController.h"
//typedef NS_ENUM(NSInteger, PushMethod) {
//    UINavigation,//导航栏推
//    Modal//模态视图推
//};


typedef void(^TransmitParams)(id  vc,NSDictionary * params);


@interface JLRouterManager : NSObject

/**
    以model 创建实列，这里传的是keyModel，注册用

 */
+ (instancetype)routerManagerWithKeyModel:(RouterModel *)model;
/**
     这是为了给发送参数用
 */
+ (instancetype)routerManager;

//默认导航栏推
- (void)registerJLRouterWithParams:(BOOL)hasParams completion:(void (^ )(void))completion destionVC:(void(^)(BaseViewController *vc))destionVCBlock;


/** 
     打开Url方法 ,参数的名称一定要对，不对会引起闪退！
 */
+ (void)openWithValueModel:(RouterModel *)model;


/**oc 对象转成字符串对象*/
+ (NSString *)OCObjToJsonObj:(id)obj;


/**json 字符串转成oc对象  */
+ (id)jsonObjToOCObj:(NSString *)json;
@end
