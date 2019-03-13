//
//  ZJPresentationController.h
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJPresentationController : UIPresentationController

// 距离顶部的高度
@property(nonatomic,assign)CGFloat height;



@property(nonatomic,strong) UIColor *colorBack;

@end

NS_ASSUME_NONNULL_END
