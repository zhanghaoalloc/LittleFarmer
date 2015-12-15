//
//  Config.h
//  Lepai
//
//  Created by huangjiancheng on 14/11/2.
//  Copyright (c) 2014年 Letv. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h


//服务器地址及加密密钥
//测试地址
#if 1
#define kCommServerUrl  @"http://www.enbs.com.cn/apps_test/index.php"
#define kCommApiKey     @"26f9a2878862d3bb27165020c6b4e7f0"

#else
//正式环境
//#define kCommServerUrl  @"http://www.enbs.com.cn/apps_2/index.php"
//#define kCommApiKey     @"457077ad3a4e86ff53fc5555"
#endif
#define kPictureURL      @"http://www.enbs.com.cn/apps_test/uploads/"

// 1, 系统函数
#pragma mark - #define System Methods


#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define APP ([APPHelper shareAppHelper])

#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )

#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

/*
 screen size
 */
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

#define kScreenSizeHeight                    [[UIScreen mainScreen] bounds].size.height
#define kScreenSizeWidth                     [[UIScreen mainScreen] bounds].size.width
#define kScreenSizeHeight_NoStatusbar        ([[UIScreen mainScreen] bounds].size.height - 20)
#define kStatusBarHeight                 20.0
#define kNavigationBarHeight             44.0
#define kBottomTabBarHeight              49.0
#define kSystemToolBarHeight             44.0

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(kScreenSizeWidth, kScreenSizeHeight))
#define SCREEN_MIN_LENGTH (MIN(kScreenSizeWidth, kScreenSizeHeight))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define kAppVersion                          ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define kAppFullVersion                      ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define kAppFullVersion                      ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define kAppName                             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

#define kSystemVersion                       [[[UIDevice currentDevice] systemVersion] floatValue]
#define kIsIpad                              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define RGBCOLOR(r,g,b)                      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBSCOLOR(sameValue)                 [UIColor colorWithRed:(sameValue)/255.0 green:(sameValue)/255.0 blue:(sameValue)/255.0 alpha:1]
#define RGBVCOLOR(rgbValue)                  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] //RGBVCOLOR(0x3c3c3c)
#define RGBACOLOR(r,g,b,a)                   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBASCOLOR(sameValue,a)              [UIColor colorWithRed:(sameValue)/255.0 green:(sameValue)/255.0 blue:(sameValue)/255.0 alpha:(a)]
#define RGBAVCOLOR(rgbValue,a)               [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)] //RGBVCOLOR(0x3c3c3c, 0.5)
#define RGBHexCOLOR(RGBAValue)      [UIColor colorWithRed:(((RGBAValue)>>24)&0xFF)/255.0 green:(((RGBAValue)>>16)&0xFF)/255.0 blue:(((RGBAValue)>>8)&0xFF)/255.0 alpha:((RGBAValue)&0xFF)/255.0]

#define FONT(value) [UIFont systemFontOfSize:value]
#define FONT_BOLD(value) [UIFont boldSystemFontOfSize:value]
//#define FONT_BOLD(value) [UIFont fontWithName:@"Helvetica-Bold" size:value]
//#define FONT(value) [UIFont fontWithName:@"Helvetica-Light" size:value]


#define OPEN_LOG
#ifdef  OPEN_LOG
#define DLOG(fmt, ...)                        NSLog((@"[Line %d] %s\r\n" fmt), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);
#define DLOG_POINT(fmt, Point, ...)           NSLog((@"[Line %d] %s" fmt @" Point :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromCGPoint(Point));
#define DLOG_SIZE(fmt, Size, ...)             NSLog((@"[Line %d] %s" fmt @" size :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromCGSize(Size));
#define DLOG_RECT(fmt, Rect, ...)             NSLog((@"[Line %d] %s" fmt @" Rect :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromCGRect(Rect));
#define DLOG_EDGEINSET(fmt, EdgeInsets, ...)  NSLog((@"[Line %d] %s" fmt @" EdgeInsets :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromUIEdgeInsets(EdgeInsets));
#define DLOG_OFFSET(fmt, Offset, ...)         NSLog((@"[Line %d] %s" fmt @" Offset :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromUIOffset(Offset));
#define DLOG_CLASS(fmt, Class, ...)           NSLog((@"[Line %d] %s" fmt @" Class :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromClass(Class));
#define DLOG_SELECTOR(fmt, Selector, ...)     NSLog((@"[Line %d] %s" fmt @" Selector :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromSelector(Selector));
#define DLOG_RANGE(fmt, Range, ...)           NSLog((@"[Line %d] %s" fmt @" Range :%@"), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__, NSStringFromRange(Range));
#else
#define DLOG(fmt, ...)
#define DLOG_POINT(fmt, Point, ...)
#define DLOG_SIZE(fmt, Size, ...)
#define DLOG_RECT(fmt, Rect, ...)
#define DLOG_EDGEINSET(fmt, EdgeInsets, ...)
#define DLOG_OFFSET(fmt, Offset, ...)
#define DLOG_CLASS(fmt, Class, ...)
#define DLOG_SELECTOR(fmt, Selector, ...)
#define DLOG_RANGE(fmt, Range, ...)
#endif

#pragma mark -- http url---
#define kHostUrl  @" "

// 2, 定义值
#pragma mark - #define Values

#define kAppID                           @"881402077"
#define kUpgradeAppKey                   @"01057020301000100010"
#define kApp_PCode                       @"150210481"
#define KAKA_SKEY                        @"73c58e1a658ac2f3c4e6a8d64fe088db"  //咔咔产品标示
#define kWhatsLiveUUID                    @"WhatsLiveUUID"

#define kEffectsBuildInVersion           @"1.0"

#define kThroughoutUsingLocalData        1

#define kOutputVideoFolder @"VideoOutput"


//友盟分享SDK
#define UMShareAppKey     @"5663c9dee0f55a74a2000b0e"

//新浪微博
#define kAppKey_sina                     @"2880108488"
#define kAppSecret_sina                  @"0c5a15dc7de1660710cad64d654c04b1"
#define kAppRedirectURI_sina             @"http://m.letv.com"

//QQ
#define kQQAppID @"1104804134"
#define kQQAppKey @"oclH9fA1PRv3h0ju"

//微信
#define kAppRedirectURI_weixin    @"your app_rederict_uri"
#define kAPPweixin            @"wxf0cf6ca93505c941"
#define kAPpKeyweixin           @"83c2c6d797f04951c0363aa82d22d6b1"

// 3, 定义通知名
#pragma mark - #define Notification Name

#define kChangedUserNotification         @"ChangedUser"
#define kBindSinaSuccNotification        @"BindSinaSuccNotification"
#define kShowHomeVCNotification          @"ShowHomeVCNotification"


// #ifdef DEBUG
#define ForTesting                       0

#if ForTesting
#define kUpgradeUsingTestDomain          1
#else
#define kUpgradeUsingTestDomain          0
#endif


/**
 Create : rect、size、point
 **/
#define RECT(x, y, width, height) CGRectMake((x), (y), (width), (height))
#define SIZE(width, height) CGSizeMake((width), (height))
#define POINT(x, y) CGPointMake((x), (y))


// 4, 其他
#pragma mark - Others


#import "UIColor+Expanded.h"
#import "MiniAppEngine.h"
#import "JudgeTextIsRight.h"
#import "UIView+Toast.h"
#import "BaseModel.h"
#import "UITextField+CustomTextField.h"
#import "NSString+CustomAttributeString.h"
#import "UILabel+CustomAttributeLabel.h"
#import "UIButton+Font.h"


#pragma mark - enum

//typedef enum
//{
//    SettingLoginTypeQQ = 0,
//    SettingLoginTypeSina,
//    SettingLoginTypeLetv,
//    SettingLoginTypeWeixin
//} SettingLoginType;
//
//
//
//#define kPlayUserInfoBroacateItem @"playUserInfoItem"
//#define kHasSSOWeiBo @"hasSSOWeiBo"
//#define isInstallWeixin [WXApi isWXAppSupportApi]
//#define kShareDefaultURL @"http://lehi.letv.com"
//#define isInstallQQ [TencentOAuth iphoneQQInstalled]
#endif
