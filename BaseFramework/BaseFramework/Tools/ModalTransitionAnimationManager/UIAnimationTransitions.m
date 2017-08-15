//
//  UIAnimationTransitions.m
//  
//
//  Created by fns on 2017/6/28.
//
//

#import "UIAnimationTransitions.h"

#define STARTRECT CGRectMake(-[[UIScreen mainScreen]bounds].size.width, 0 , [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)
#define ENDRECT [UIScreen mainScreen].bounds

@interface UIAnimationTransitions () {
    CGRect _startFrame;//初始frame
    CGRect _endFrame;//结束的frame
    NSTimeInterval _delay;//动画延迟时间
}

@end

@implementation UIAnimationTransitions

- (instancetype)init {
    self = [super init];
    if (self) {
        _startFrame     = STARTRECT;
        _endFrame       = ENDRECT;
        _delay          = 0.0;
        _durationTiming = 0.5;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _durationTiming;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView  = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];//所有转场动画的View 都需要加到这个容器view上去操作
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    switch (_typeAnimation) {
        case 0:{
            fromView.frame    = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
            [UIView animateWithDuration:_durationTiming - _delay delay:_delay options:UIViewAnimationOptionLayoutSubviews animations:^{
                fromView.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                if ([transitionContext transitionWasCancelled]) {
                    [containerView bringSubviewToFront:fromView];
                }
            }];
        }
            break;
        case 1:{
            toView.frame    = _startFrame;
            [UIView animateWithDuration:_durationTiming - _delay delay:_delay usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
                toView.frame = _endFrame;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:finished];
            }];

        }
            break;
        default:
            break;
    }
    
}

@end
