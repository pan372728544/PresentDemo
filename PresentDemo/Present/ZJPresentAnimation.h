//
//  ZJPresentAnimation.h
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

//用于记录控制器是创建还是销毁
@property (nonatomic, assign ) BOOL presented;

// 左右滑动
@property (nonatomic, assign ) BOOL isRight;

@end

NS_ASSUME_NONNULL_END
