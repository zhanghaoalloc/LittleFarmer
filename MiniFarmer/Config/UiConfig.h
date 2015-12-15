//
//  UiConfig.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/11.
//  Copyright © 2015年 enbs. All rights reserved.
//


#pragma mark- 颜色

#define kLightBlueColor             RGBCOLOR(0,153,255)
#define kTextBlackColor             RGBCOLOR(51,51,51)
#define kTextLightBlackColor        RGBCOLOR(153, 153, 153)
//分隔线颜色
#define kSeparatorColor             RGBCOLOR(221, 221, 221)

//背景颜色
#define kBgGrayColor             RGBCOLOR(238, 238, 238)

#pragma mark- 字体
#define kTextFont18         [UIFont systemFontOfSize:18]
#define kTextFont16         [UIFont systemFontOfSize:16]
#define kTextFont14         [UIFont systemFontOfSize:14]
#define kTextFont12         [UIFont systemFontOfSize:12]
#define kTextFont(A)        [UIFont systemFontOfSize:A]


#pragma mark - 线的宽度

#define kLineWidth 1 / ([[UIScreen mainScreen] scale] * 1.0)


#pragma mark - 系统
#define kNavigationBarHeigth 44
#define kStatusBarHeigth 20

#pragma mark--本地
#define KHistory   @"history"
