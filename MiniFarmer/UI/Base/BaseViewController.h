//
//  UserBaseViewController.h
//  Lepai
//
//  Created by 尹新春 on 15/7/23.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import "SimpleImageTitleButton.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) SimpleImageTitleButton *backBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, readwrite) CGFloat yOffset;

@property (nonatomic, assign) CGFloat yDispaceToTop;


- (void)initTitleLabel:(NSString *)title;

- (void)initNavigationBottomLine;

- (void)initBackButton;

- (void)backPreView:(id)sender;

/**
 *  创建右默认按钮
 */
- (void)initRightButton;

/**
 *  右默认按钮响应事件(默认无,在子类重写实现)
 */
- (void)rightButtonPressed:(id)sender;

/**
 *  创建导航栏底图(包含状态栏部分)
 */
- (void)initNavigationbgView:(UIColor *)color;

/**
 *  创建导航栏背景图(包含状态栏部分)
 */
- (void)initNavigationbgImage:(UIImage *)image;

/**
 *  设置状态栏为亮色
 */
- (void)lightStatusBar;

/**
 *  设置状态栏为暗色
 */
- (void)darkStatusBar;

@end
