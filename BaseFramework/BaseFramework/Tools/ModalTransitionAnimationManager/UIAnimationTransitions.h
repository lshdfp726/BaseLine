//
//  UIAnimationTransitions.h
//  
//
//  Created by fns on 2017/6/28.
//
//

#import <Foundation/Foundation.h>
//动画类型
typedef NS_ENUM(NSInteger, AnimationType) {
    TranslationAnimation = 0,//平移动画，上、左、下、右
    SpringAnimation,//弹簧动画
};


@interface UIAnimationTransitions : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval durationTiming;//动画持续时间
@property (nonatomic, assign) CGRect startFrame;//初始的frame，默认为windonw 左边
@property (nonatomic, assign) CGRect endFrame;//结束的frane//默认为windown 的bounds
@property (nonatomic, assign) AnimationType typeAnimation;
@property (nonatomic, assign) NSTimeInterval delay;//设置动画延时时间
@end
