//
//  ZJBasePresentViewController.m
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import "ZJBasePresentViewController.h"
#import "ZJPresentAnimation.h"
#import "ZJPresentationController.h"

@interface ZJBasePresentViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition*
interactiveTransition;

@property (nonatomic, strong) UIPanGestureRecognizer * pan;

@end

@implementation ZJBasePresentViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isSupportRightSlide = NO;
        // 设置代理和present样式
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] init];
    pan.delegate = self;
    [pan addTarget:self action:@selector(panGestureRecognizerAction:)];
    self.view.tag = 10001;
    self.pan = pan;
    [self.view addGestureRecognizer:pan];
}



-(void)setIsSupportRightSlide:(BOOL)isSupportRightSlide
{
    _isSupportRightSlide = isSupportRightSlide;
    if (_isSupportRightSlide) {
        
        [self addSwipeGesture];
    }
}

-(void)addSwipeGesture
{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeGesture:)];

    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
}

-(void)SwipeGesture:(UISwipeGestureRecognizer *)swipe
{

}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan
{
    
    // 滑动进度0~1；
    CGFloat process = 0;
    
    if (self.isSupportRightSlide) {
        // 同时支持右滑和下拉
        process =[self supportRightSlideWithPanGest:pan];
    }
    else
    {
        // 只有下拉返回
        process = ([pan translationInView:self.view].y) / SCREEN_H;
        process = MIN(1.0,(MAX(0.0, process)));
    }


    // 开始滑动的时候
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
        // 触发dismiss转场动画
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    // 手势滑动的时候
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        [self.interactiveTransition updateInteractiveTransition:process];
    }
    // 滑动手势结束或者取消
    else if (pan.state == UIGestureRecognizerStateEnded
             || pan.state == UIGestureRecognizerStateCancelled)
    {
        // 滑动百分比大于0.3完成动画
        if (process >= 0.3)
        {
            [ self.interactiveTransition finishInteractiveTransition];
        }
        else
        {
            [ self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
        
        self.isRight = NO;
        self.isUp = NO;
    }
}


-(CGFloat)supportRightSlideWithPanGest:(UIPanGestureRecognizer *)pan
{

    CGFloat process = 0;
    CGFloat upSlide =[pan translationInView:self.view].y;
    CGFloat rightSlide =[pan translationInView:self.view].x;
    
    // 判断滑动方向
    if (rightSlide>=upSlide && !self.isUp)
    {
        // 向➡️滑动
        self.isRight = YES;
        self.isUp = NO;
        // 产生百分比
        process = ([pan translationInView:self.view].x) / SCREEN_W;
    }
    else
    {
        // 正在向右滑动
        if (self.isRight)
        {
            self.isUp = NO;
            process = ([pan translationInView:self.view].x) / SCREEN_W;
        }
        else
        {
            // 向⬇️滑动
            self.isUp = YES;
            self.isRight = NO;
            process = ([pan translationInView:self.view].y) / SCREEN_H;
            
        }
    }
    process = MIN(1.0,(MAX(0.0, process)));
    return process;
}

#pragma mark - UIViewControllerTransitioningDelegate
// 设置继承自UIPresentationController 的自定义类的属性
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    
    ZJPresentationController *presentVC = [[ZJPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    // 设置距离顶部的高度
    presentVC.height = STATUSBAR_H;
    
    return presentVC;
}

//控制器创建执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    //创建实现UIViewControllerAnimatedTransitioning协议的类（命名为AnimatedTransitioning）
    ZJPresentAnimation *animation = [[ZJPresentAnimation alloc] init];
    
    //将其状态改为出现
    animation.presented = YES;
    
    
    return animation;
}

// 控制器销毁执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

    ////创建实现UIViewControllerAnimatedTransitioning协议的类（命名为AnimatedTransitioning）
    ZJPresentAnimation *animation = [[ZJPresentAnimation alloc] init];

    //将其状态改为出现
    animation.presented = NO;
    NSLog(@"ZJPresentAnimation  %d",self.isRight);
    animation.isRight = self.isRight;
    return animation;
}

// 返回一个交互的对象（实现UIViewControllerInteractiveTransitioning协议的类）
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveTransition;
}


@end

