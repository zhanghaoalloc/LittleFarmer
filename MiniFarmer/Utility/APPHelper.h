//
//  APPHelper.h
//  PopupImages
//
//  Created by lic on 14/12/22.
//  Copyright (c) 2014年 lic. All rights reserved.
//
//  app window

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol AppUpgradeToolProtocol;

@interface APPHelper : NSObject

@property (nonatomic, readonly) AppDelegate *appDelegate;
@property (nonatomic, strong) UIWindow *window;

+ (APPHelper *)shareAppHelper;
- (void)configureWindow:(UIWindow *)window;
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;
+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;
//关闭键盘
+ (void)closeKeyboard;
//存图片到cache
+ (void)storeImageLocalWithName:(NSString *)imgName withImage:(UIImage *)image;
//显示gif hud
- (void)showGifHUD;
//消失gif hud
- (void)dismissGifHUD;
//显示gif
- (void)showGifHudWithDuration:(double)duration;

+(BOOL)isIphone6Plus;

+(BOOL)isIphone6;

- (BOOL)checkNetwork:(UIView *)view;

//图片等比缩放
- (UIImage *)imageByScalingAndCroppingToSize:(CGSize)size withImage:(UIImage *)image;

//如果字放不下的时候就换行
+ (CGSize)getStringWordWrappingSize:(NSString *)string andConstrainToSize:(CGSize)size andFont:(UIFont *)font;
//如果字放不下的时候就变成。。。
+ (CGSize)getStringStyleTruncatTailWithSize:(NSString *)string andConstrainToSize:(CGSize)size andFont:(UIFont *)font;
//统计字符数
+ (int)countTheStrLength:(NSString*)strtemp;
//是否为空字符串
+ (BOOL)isBlankString:(NSString *)string;

//时间转时间戳
- (NSString *)dateToTimeStamp:(NSDate *)date;

//时间戳转时间字符串
- (NSString *)timeStampToDateInterval:(NSTimeInterval)times;

//根据系统语言，转换时间
- (NSString *)getLocaleTime: (NSDate *)date withFormatter:(NSString *)format;

//获取系统语言
+ (NSString *)getCurrentLanguage;

+ (NSString *)safeString:(NSString *)safeString;

+ (NSArray *)safeArray:(NSArray *)arr;

+ (BOOL)empty:(NSObject *)object;

+ (NSString *)getDateWithInter:(NSTimeInterval)interval;
+ (NSString *)getOrderWithInter:(NSTimeInterval)interval;
+ (NSString *)timeFormatted:(int)totalSeconds;


//数字超过1000时显示 x.xk
- (NSString *)kNumWithNumber:(NSString*)nums;

//- (NSString *)currentDeviceUUID;

- (UIViewController *)getCurrentViewController;

+ (BOOL)isChinaLanguage;

//第一次询问权限
- (void)alertAuthorization;

//麦克风权限
- (BOOL)microphoneAuthorization;
//相册权限
- (BOOL)assetsLibraryAuthorization;
//摄像头权限
- (BOOL)isAuthorizationAVCaptureDevice;
/**按比例压缩图片*/
+ (NSData *)compressionImage:(NSString *)imageURL;
/**压缩图片到指定大小*/
+ (NSData *)compressionImageToSize:(CGSize)size WithImageURL:(NSString *)imageURL;

+ (NSString *)timesDifferenceWithEndDate:(NSDate *)endDate startDate:(NSDate *)startDate;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (BOOL)isShouldChangeTextFiledWithStr:(NSString *)str maxCount:(NSInteger)maxCount range:(NSRange)range text:(NSString *)text textField:(UITextField *)textField;
+ (BOOL)isShouldChangeTextViewWithStr:(NSString *)str maxCount:(NSInteger)maxCount range:(NSRange)range text:(NSString *)text textView:(UITextView *)textView;
+ (NSString *)substringWithString:(NSString *)string MaxNumber:(int)number;

/**
 *  统计字符个数新方法
 */
+ (int)countStringLength:(NSString *)strtemp;

+ (NSString *)newStringWithStr:(NSString *)str
                    totalCount:(NSInteger)totalCount
                     hasLength:(NSInteger)hasLength;

+ (NSString *)newNumWithNums:(NSString*)nums;
//ip 地址校验
+ (BOOL)isValidatIP:(NSString *)ipAddress;

//时间描述
+ (NSString *)describeTimeWithMSec:(NSString *)twsj;
@end
