//
//  BaseViewController+Navigation.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/1.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (Navigation)



- (void)setNavigationBarIsHidden:(BOOL)hidden;

//自定义左边的按钮
- (void)setBarLeftDefualtButtonWithTarget:(id)target action:(SEL)action;
//自定义右边
- (void)setBarRightDefaultButtonWithTarget:(id)target action:(SEL)action;

- (void)setLineToBarBottomWithColor:(UIColor *)color heigth:(CGFloat)heigth;

/// 设置default返回按钮
- (void)setLeftDefualtButtonBackWithTarget:(id)target action:(SEL)action;
- (void)setNaVIgationBackAction:(id)target action:(SEL)action;

//设置右边默认的button
- (void)setRightDefaultButtonBackWithTarget:(id)target action:(SEL)action;

- (void)setBarTitle:(NSString *)title;

//添加手势 回收键盘
- (void)addGestureWithTarget:(id)target action:(SEL)action;

- (void)addGesture;

- (void)setStatusBarColor:(UIColor *)color;


@end
