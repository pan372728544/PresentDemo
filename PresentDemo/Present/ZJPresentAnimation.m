//
//  ZJPresentAnimation.m
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import "ZJPresentAnimation.h"

@interface ZJPresentAnimation()

@end


@implementation ZJPresentAnimation


// 自定义转场动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.34f;
}


// 自定义转成动画具体实现
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 获取viewcontroller
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    UIView* transView = nil;
    UIView *contentView = nil;
    
    
    
    for (UIView *subView in [[transitionContext containerView] subviews]) {
        if (subView.tag == 1001 || subView.tag == 1002) {
            [subView removeFromSuperview];
        }
    }
    contentView = [transitionContext containerView];
    
    // 获取view
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    // 如果是present
    if (_presented) {
        // 记录present的view
        transView = toView;
        
    }else {
        transView = fromView;
    }
    
    [contentView addSubview:transView];
    //    [[transitionContext containerView] insertSubview:transView aboveSubview:self.viewCover];
    
    
    // y值
    CGFloat y = transView.frame.origin.y;
    
    transView.frame = CGRectMake(0, _presented ?SCREEN_H :y, SCREEN_W, SCREEN_H);
    
    
    if (_presented) {
        
        
        
        UIView   *viewCoverf = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        viewCoverf.backgroundColor = [UIColor blackColor];
        viewCoverf.alpha = 0.5;
        viewCoverf.tag = 1001;
        [contentView insertSubview:viewCoverf belowSubview:transView];
        
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            transView.frame = CGRectMake(0, y , SCREEN_W, SCREEN_H);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }
    else
    {
        
        
        
        UIView   *viewCovert = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        viewCovert.backgroundColor = [UIColor blackColor];
        viewCovert.alpha = 0.5;
        viewCovert.tag = 1002;
        [contentView insertSubview:viewCovert belowSubview:transView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            transView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);
            viewCovert.alpha= 0;
        } completion:^(BOOL finished) {
            if (!transitionContext.transitionWasCancelled) {
                [viewCovert removeFromSuperview];
            }
            
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

@end

