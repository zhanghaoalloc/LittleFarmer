//
//  UserBaseViewController.m
//  Lepai
//
//  Created by 尹新春 on 15/7/23.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewAdditions.h"

@interface BaseViewController ()
@property (nonatomic, strong) UILabel *navTitleLabel;
@property (nonatomic, strong) UIImageView *lineImageView;

/**
 *  导航栏背景图
 */
@property (nonatomic, strong) UIImageView *backgroungImgV;
/**
 *  导航栏底图
 */
@property (nonatomic, strong) UIView *backgroungView;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initBackButton];
    _backBtn.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)initBackButton
{
    if (!_backBtn) {
        _backBtn = [[SimpleImageTitleButton alloc] initWithFrame:CGRectMake(18, 0, 44, 44)];
        [_backBtn setTop:kStatusBarHeight];
        CGFloat edgeInset = (44-24)/2;
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(edgeInset, edgeInset, edgeInset, edgeInset)];
        [_backBtn setImage:[UIImage imageNamed:@"back_nm"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"back_hl"] forState:UIControlStateHighlighted];
        [_backBtn setImage:[UIImage imageNamed:@"back_hl"] forState:UIControlStateSelected];
        [_backBtn setTitle:@""];
        [_backBtn setTitleFont:[UIFont systemFontOfSize:15]];
        //[_backBtn setTitleColor:kBackTitleColor forState:UIControlStateNormal];
        [_backBtn setLeftImageSize:CGSizeMake(24, 24) imageLeftWidth:0 titleToImageWidth:10];
        [self.view addSubview:_backBtn];
        [_backBtn addTarget:self action:@selector(backPreView:) forControlEvents:UIControlEventTouchUpInside];
        self.yOffset = _backBtn.height + kStatusBarHeight;
    }
    _backBtn.hidden = NO;
}

- (void)initRightButton{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(18, 0, 24, 24);
        _rightBtn.centerY = 42;
        _rightBtn.right = kScreenSizeWidth - 10;
        _rightBtn.contentMode = UIViewContentModeRight;
        [_rightBtn setImage:[UIImage imageNamed:@"done_nm"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"done_hl"] forState:UIControlStateHighlighted];
        [_rightBtn setImage:[UIImage imageNamed:@"done_hl"] forState:UIControlStateSelected];
        [_rightBtn.titleLabel setFont:FONT(15)];
        [self.view addSubview:_rightBtn];
        [_rightBtn addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    _rightBtn.hidden = NO;
}

- (void)initNavigationBottomLine
{
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, kScreenSizeWidth, 3 / [UIScreen mainScreen].scale * 1.0)];
    self.lineImageView.bottom = self.lineImageView.bottom - self.lineImageView.height;
    //self.lineImageView.backgroundColor = [UIColor colorWithHexString:@"222222"];
    
    
    [self.view addSubview:self.lineImageView];
}

- (void)initTitleLabel:(NSString *)title
{
    self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _navTitleLabel.center = CGPointMake(self.view.width/2, 42);
    _navTitleLabel.textAlignment = NSTextAlignmentCenter;
    //[_navTitleLabel setTextColor:[UIColor colorWithHexString:@"#8990A2"]];
    _navTitleLabel.text = title;
    [_navTitleLabel setFont:[UIFont systemFontOfSize:18]];
    _navTitleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navTitleLabel];
}

//创建导航栏底图(包含状态栏部分)
- (void)initNavigationbgView:(UIColor *)color{
    self.backgroungView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kNavigationBarHeight + kStatusBarHeight)];
    self.backgroungView.backgroundColor = color;
    
    [self.view addSubview:self.backgroungView];
    [self.view sendSubviewToBack:self.backgroungView];
}

//创建导航栏背景图(包含状态栏部分)
- (void)initNavigationbgImage:(UIImage *)image{
    self.backgroungImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kNavigationBarHeight + kStatusBarHeight)];
    self.backgroungImgV.image = image;
    
    [self.view addSubview:self.backgroungImgV];
    [self.view sendSubviewToBack:self.backgroungView];
}

//设置状态栏为亮色
- (void)lightStatusBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

//设置状态栏为暗色
- (void)darkStatusBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

#pragma mark ----- 响应相关
//左按钮点击
- (void)backPreView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//右按钮点击
- (void)rightButtonPressed:(id)sender{
    
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
}


@end
