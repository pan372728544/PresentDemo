//
//  ZJBasePresentViewController.h
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBasePresentViewController : UIViewController


// 是否支持向右滑动返回（默认不支持，默认为NO）
@property(nonatomic,assign)BOOL isSupportRightSlide;


@property(nonatomic,assign)BOOL isUp;

@property(nonatomic,assign)BOOL isRight;


@end

NS_ASSUME_NONNULL_END
