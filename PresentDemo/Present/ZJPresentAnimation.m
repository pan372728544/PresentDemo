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
    
    // 到哪个vc
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 从哪个vc来
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 获取过渡时候的容器view
    UIView *contentView  = [transitionContext containerView];;
    
    
    // 移除之前的
    for (UIView *subView in [contentView subviews]) {
        if (subView.tag == 1001 ) {
            [subView removeFromSuperview];
        }
    }
    
    UIView * transView = nil;
    // 如果是present
    if (_presented) {
        // 记录present的view
        transView = toViewController.view;
        
    }
    else {
        transView = fromViewController.view;
    }
    
    // y值
    CGFloat y = transView.frame.origin.y;
    transView.frame = CGRectMake(0, _presented ?SCREEN_H :y, SCREEN_W, SCREEN_H);
    
    // 黑色背景
    UIView  *viewCover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    viewCover.backgroundColor = [UIColor blackColor];
    viewCover.alpha = 0.5;
    viewCover.tag = 1001;
    [contentView insertSubview:viewCover belowSubview:transView];
    
    if (_presented) {
        
        // 执行动画过程
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            transView.frame = CGRectMake(0, y , SCREEN_W, SCREEN_H);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }
    else
    {
        // 右滑返回
        if (self.isRight) {
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                transView.frame = CGRectMake(SCREEN_W, y, SCREEN_W, SCREEN_H);
                viewCover.alpha= 0;
            } completion:^(BOOL finished) {
                if (!transitionContext.transitionWasCancelled) {
                    [viewCover removeFromSuperview];
                }
                
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
        
        else
        {
            // 下拉动画
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                transView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);
                viewCover.alpha= 0;
            } completion:^(BOOL finished) {
                if (!transitionContext.transitionWasCancelled) {
                    [viewCover removeFromSuperview];
                }
                
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
    }
}

@end

