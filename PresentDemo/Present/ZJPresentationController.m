//
//  ZJPresentationController.m
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import "ZJPresentationController.h"

@implementation ZJPresentationController


//即将出现调用
- (void)presentationTransitionWillBegin{
    [super presentationTransitionWillBegin];
    
    // 设置present视图的高度
    self.presentedView.frame = CGRectMake(0, _height, SCREEN_W, SCREEN_H);
    //    self.presentedView.backgroundColor = [UIColor whiteColor];
    self.presentedView.layer.cornerRadius = 7;
    // 添加到containerView 上
    [self.containerView addSubview:self.presentedView];
    
}

//出现调用
- (void)presentationTransitionDidEnd:(BOOL)completed{
    // 如果呈现没有完成，那就移除背景 View
    [super presentationTransitionDidEnd:completed];
}

//即将销毁调用
- (void)dismissalTransitionWillBegin{
    [super dismissalTransitionWillBegin];
}

//销毁调用
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    [super dismissalTransitionDidEnd:completed];
    if (completed) {
        //一旦要自定义动画，必须自己手动移除控制器
        [self.presentedView removeFromSuperview];
        
    }
    
}

@end

