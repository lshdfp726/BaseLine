//
//  ModalDefineAnimationTransition.h
//  UsualTest
//
//  Created by fns on 2017/6/29.
//  Copyright © 2017年 fns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAnimationTransitions.h"

@class UIViewControllerTransitioningDelegate;


/**
     自定义转场类，针对modal 视图返回自定义手势返回！
     使用时候特别注意：需要定制modal的视图返回时候的 vc.transitioningDelegate = ModalDefineAnimationTransition的实列，否则转场的代理不会走
     使用这个类时一定要申明成全局变量，如果是局部变量响应的block 不会触发！具体原因大概就是系统事件分发时候没有找到这个类（自己总结的，原因不一定正确）
 */


@interface ModalDefineAnimationTransition : NSObject<UIViewControllerTransitioningDelegate>
//动画的属性设置
@property (nonatomic, assign) NSTimeInterval durationTiming;//动画持续时间
@property (nonatomic, assign) CGRect startFrame;//初始的frame
@property (nonatomic, assign) CGRect endFrame;//结束的frane
@property (nonatomic, assign) AnimationType typeAnimation;
@property (nonatomic, assign) NSTimeInterval delay;//设置动画延时时间


/**
     reg 定制的手势
     destionView，手势需要加到的view上
     InteractiveBlock 返回给的block，interActive 是动画手势定制类，具体可以进入这个类看看几个方法，
 */

- (void)lsh_getInteractiveWithGestureRecognizer:(UIGestureRecognizer *)reg
                                      AddToView:(UIView *)destionView
                               InteractiveBlock:(void(^)(UIPercentDrivenInteractiveTransition *interActive, UIGestureRecognizer *reg))interactiveblock;

@end
