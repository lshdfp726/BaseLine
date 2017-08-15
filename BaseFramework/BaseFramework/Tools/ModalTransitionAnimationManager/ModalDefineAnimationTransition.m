


//
//  ModalDefineAnimationTransition.m
//  UsualTest
//
//  Created by fns on 2017/6/29.
//  Copyright © 2017年 fns. All rights reserved.
//

#import "ModalDefineAnimationTransition.h"
#import <objc/runtime.h>

const void *key = &key;

@interface ModalDefineAnimationTransition ()  {
    UIAnimationTransitions *_animated;
    UIPercentDrivenInteractiveTransition *_interactive;
}

@end

@implementation ModalDefineAnimationTransition

- (instancetype)init {
    self = [super init];
    if (self) {
        _animated                  = [[UIAnimationTransitions alloc] init];
        _interactive               = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}


#pragma mark - UIViewControllerTransitioningDelegate 代理方法
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return nil;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _animated;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _interactive;
}


- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return nil;
}



- (void)lsh_getInteractiveWithGestureRecognizer:(UIGestureRecognizer *)reg
                                      AddToView:(UIView *)destionView
                               InteractiveBlock:(void(^)(UIPercentDrivenInteractiveTransition *interActive, UIGestureRecognizer *reg))interactiveblock {
    [destionView addGestureRecognizer:reg];
    
    [reg addTarget:self action:@selector(gestAction:)];
   
    objc_setAssociatedObject(self, key, interactiveblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)gestAction:(UIGestureRecognizer *)reg {
    void(^block)(UIPercentDrivenInteractiveTransition *interActive, UIGestureRecognizer *reg) = objc_getAssociatedObject(self, key);
    if (block) {
        block(_interactive,reg);
    }
}


//遍历寻找VC
- (id)nextResponse:(id)response {
    id next = [response nextResponder];
    if ([[response nextResponder] isKindOfClass:[UIViewController class]]) {
        return next;
    } else {
        return [self nextResponse:next];
    }
}


- (void)setGestureWithGesture:(UIGestureRecognizer *)reg
                   targetView:(UIView *)view
                  actionBlock:(void(^)(UIPercentDrivenInteractiveTransition *interactive))block {
    

    block(_interactive);
}




#pragma mark - 动画属性赋值！
- (void)setStartFrame:(CGRect)startFrame {
    _startFrame          = startFrame;
    _animated.startFrame = startFrame;
}


- (void)setEndFrame:(CGRect)endFrame {
    _endFrame          = endFrame;
    _animated.endFrame = endFrame;
}


- (void)setDurationTiming:(NSTimeInterval)durationTiming {
    _durationTiming = durationTiming;
    _animated.durationTiming = durationTiming;
}


- (void)setDelay:(NSTimeInterval)delay {
    _delay = delay;
    _animated.delay = delay;
}


- (void)setTypeAnimation:(AnimationType)typeAnimation {
    _typeAnimation = typeAnimation;
    _animated.typeAnimation = typeAnimation;
}



@end
