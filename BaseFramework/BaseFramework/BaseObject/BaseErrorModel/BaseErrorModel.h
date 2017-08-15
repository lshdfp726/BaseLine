//
//  BaseErrorModel.h
//  zheft
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseErrorModel : NSObject
/** 错误码 
 1-未知错误
 2-网络未连接，请检查网络
 3-当前网络不佳，请稍后重试
 4-请求失败，请重试
 5-服务器错误
 6-服务器返回异常
 7-失去连接，请重试
 8-下载失败
 9-非法URL
 10-未能连接到服务器
 11-未知的code
 */
@property (nonatomic, assign) NSInteger errorCode;;

/** 错误信息 */
@property (nonatomic, copy) NSString *errorMsg;
@end
