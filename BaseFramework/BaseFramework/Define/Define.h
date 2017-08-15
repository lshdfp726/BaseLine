//
//  Define.h
//  BaseFramework
//
//  Created by fns on 2017/8/15.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#ifndef Define_h
#define Define_h

// 定义颜色
#define RGB(r,g,b) ([UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b /255.0 alpha:1.0])
#define RGBA(r,g,b,a) ([UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b /255.0 alpha:a/1.0])

//背景颜色
#define  commonBackgroundColor ([UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 /255.0 alpha:1.0])
// 灰背景颜色
#define  commonGrayBackgroundColor ([UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 /255.0 alpha:1.0])

//字体文本
#define COMMONFONT(parmas) [UIFont systemFontOfSize:parmas]

// 分隔线的高度
#define  commonSeparatorLineHeight 0.5
/** 分隔线颜色 */
#define  commonSeparatorLineColor ([UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 /255.0 alpha:0.8])

//Masnory  弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kWeakObj(obj)  __weak typeof(obj) weakObj = obj;

#endif /* Define_h */
