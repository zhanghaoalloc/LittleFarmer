//
//  APPHelper.m
//  PopupImages
//
//  Created by lic on 14/12/22.
//  Copyright (c) 2014年 lic. All rights reserved.
//

#import "APPHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SHHttpClient.h"
#import "GiFHUD.h"


#define kCompressionQuality 0.1

@interface APPHelper ()

@end

@implementation APPHelper

- (id)init
{
    if (self = [super init]) {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSString* gifName = @"change_loading@2x.gif";
        if([APPHelper isIphone6Plus])
        {
            gifName = @"change_loading@3x.gif";
        }
        
        [GiFHUD setGifWithImageName:gifName];
    }
    return self;
}

+ (APPHelper *)shareAppHelper
{
    static dispatch_once_t onceQueue;
    static APPHelper *appHelper = nil;
    
    dispatch_once(&onceQueue, ^(){
        appHelper = [[APPHelper alloc] init];
    
    });
    return appHelper;
}

- (UIWindow *)window
{
    return self.appDelegate.window;
}

//设置 app window；
- (void)configureWindow:(UIWindow *)window
{
//e.g
    UINavigationController *navController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    
    window.rootViewController = navController;
}

//date <=> string
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateString];
}

/**
 *  校验手机号
 *
 *  @param phoneNumber phone number
 *
 *  @return 
 */
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2-478]|78)\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349|77[0-9])\\d{7}$";
    NSString * CV = @"^1(70[059])\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestcv = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CV];
    BOOL res1 = [regextestmobile evaluateWithObject:phoneNumber];
    BOOL res2 = [regextestcm evaluateWithObject:phoneNumber];
    BOOL res3 = [regextestcu evaluateWithObject:phoneNumber];
    BOOL res4 = [regextestct evaluateWithObject:phoneNumber];
    BOOL res5 = [regextestcv evaluateWithObject:phoneNumber];
    
    if (res1 || res2 || res3 || res4 || res5)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//关闭键盘
+ (void)closeKeyboard
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

+ (void)storeImageLocalWithName:(NSString *)imgName withImage:(UIImage *)image
{
    NSData *imgData;
    if (UIImagePNGRepresentation(image) == nil) {
        imgData = UIImageJPEGRepresentation(image, 1);
    }else{
        imgData = UIImagePNGRepresentation(image);
    }
    
//    [AppPath storeFileToCacheDirectoryWithFileName:imgName withData:imgData];
}

- (void)showGifHUD
{
    [GiFHUD show];
}

- (void)dismissGifHUD
{
    [GiFHUD dismiss];
}

- (void)showGifHudWithDuration:(double)duration
{
    [GiFHUD showWithOverlay];
    
    // dismiss after 2 seconds
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [GiFHUD dismiss];
    });

}


+ (BOOL)isIphone6Plus
{
    BOOL bIphone6P = NO;
    
    if([UIScreen instancesRespondToSelector:@selector(currentMode)])
    {
        
        bIphone6P = CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen]currentMode].size);
    }
    
    return bIphone6P;
}

+ (BOOL)isIphone6
{
    BOOL bIphone6P = NO;
    
    if([UIScreen instancesRespondToSelector:@selector(currentMode)])
    {
       
        bIphone6P = CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen]currentMode].size);
    }
    
    return bIphone6P;
}

- (BOOL)checkNetwork:(UIView *)view
{
    BOOL ys = YES;
    if ([[SHHttpClient defaultClient] isConnectionAvailable]) {
        
        ys = YES;
    }else{
//        [ToastUtil showToastInWindow:NONETWORK_TOTAST_TITLE];
        ys = NO;
    }
    return ys;
    
}

#pragma mark - Authorization ---
- (void)alertAuthorization
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
        }];
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            
        }];
    }
}

- (BOOL)assetsLibraryAuthorization
{
    BOOL author = YES;
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version >= 6.0f){
        int author = [ALAssetsLibrary authorizationStatus];
        if(author != ALAuthorizationStatusAuthorized && author != ALAuthorizationStatusNotDetermined){
            author = NO;
            
        }
    }
    return author;
}

- (BOOL)isAuthorizationAVCaptureDevice
{
    BOOL ison = YES;
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version >= 7.0f){
        AVAuthorizationStatus authorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorStatus == AVAuthorizationStatusRestricted || authorStatus == AVAuthorizationStatusDenied) {
            ison = NO;
        }
    }
    return ison;
}

- (BOOL)microphoneAuthorization
{
    __block BOOL isOn = YES;
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version >= 7.0f){
        if([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)])
        {
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (!granted) {
                    isOn = NO;
                }
            }];
        }
        
    }
    return isOn;
}


//图片等比缩放
- (UIImage *)imageByScalingAndCroppingToSize:(CGSize)size withImage:(UIImage *)image
{
    if (CGSizeEqualToSize(image.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return image;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / image.size.width;
    CGFloat heightFactor = size.height / image.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = image.size.width * scaleFactor;
    scaledSize.height = image.size.height * scaleFactor;
    
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (CGSize)getStringWordWrappingSize:(NSString *)string andConstrainToSize:(CGSize)size andFont:(UIFont *)font{
    CGSize labelsize;
    if (IOS7_OR_LATER) {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        labelsize = [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
        labelsize.width = ceil(labelsize.width);
        labelsize.height = ceil(labelsize.height);
    }else{
//        UIFont *font = [UIFont systemFontOfSize:fontSize];
//        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
    }
    
    return labelsize;
}

+ (CGSize)getStringStyleTruncatTailWithSize:(NSString *)string andConstrainToSize:(CGSize)size andFont:(UIFont *)font
{
    CGSize labelsize;
    if (IOS7_OR_LATER) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        labelsize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    }else{
//        UIFont *font = [UIFont systemFontOfSize:fontSize];
//        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];
    }
    CGFloat width = ceilf(labelsize.width);
    CGFloat heigth = ceilf(labelsize.height);
    return CGSizeMake(width, heigth);
}

//统计字符个数（包含中英文特殊字符）
+ (int)countTheStrLength:(NSString*)strtemp
{
    int strLength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i ++) {
        if (*p) {
            p ++;
            strLength ++;
        }else{
            p ++;
        }
    }
    return (strLength+1)/2;
}

+ (NSString *)safeString:(NSString *)safeString
{
    if ([APPHelper isBlankString:safeString])
    {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@",safeString];
}

+ (NSArray *)safeArray:(NSArray *)arr
{
    if ([APPHelper empty:arr])
    {
        return [NSArray array];
    }
    return [NSArray arrayWithArray:arr];
}

+ (BOOL)empty:(NSObject *)object
{
    if (object == nil)
    {
        return YES;
    }
    if (object == NULL)
    {
        return YES;
    }
    if (object == [NSNull new])
    {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]])
    {
        return [APPHelper isBlankString:(NSString *)object];
    }
    if ([object isKindOfClass:[NSData class]])
    {
        return [((NSData *)object) length]<=0;
    }
    if ([object isKindOfClass:[NSDictionary class]])
    {
        return [((NSDictionary *)object) count]<=0;
    }
    if ([object isKindOfClass:[NSArray class]])
    {
        return [((NSArray *)object) count]<=0;
    }
    if ([object isKindOfClass:[NSSet class]])
    {
        return [((NSSet *)object) count]<=0;
    }
    return NO;
}

+ (BOOL)isBlankString:(NSString *)string
{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isEqual:nil]
        ||  [string isEqual:Nil]){
        return YES;
    }
    if (![string isKindOfClass:[NSString class]])
    {
        return YES;
    }
    if (0 == [string length]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if([string isEqualToString:@"(null)"]){
        return YES;
    }
    
    return NO;
    
}

- (NSString *)getLocaleTime: (NSDate *)date withFormatter:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    
    NSLocale *gbLocale = [[NSLocale alloc] initWithLocaleIdentifier:[APPHelper getCurrentLanguage]];
    [formatter setLocale:gbLocale];
    
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    DLOG(@"date====%@", currentDateString);
    return currentDateString;
}

+ (NSString *)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    DLOG( @"%@" , currentLanguage);
    //en/zh-Hans
    return currentLanguage;
}

- (NSString *)dateToTimeStamp:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSTimeInterval value1 = [date timeIntervalSince1970];
    NSString *timeStr = [self timeStampToDateInterval:value1];
    NSDate *tDate = [formatter dateFromString:timeStr];
    NSInteger value2 = (NSInteger)[tDate timeIntervalSince1970];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld000", (long)value2];
    DLOG(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
}

- (NSString *)timeStampToDateInterval:(NSTimeInterval)times
{
//    NSTimeInterval time = [timeStamp floatValue] / 1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"]; // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:times];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    DLOG(@"confromTimespStr =  %@",confromTimespStr);
    return confromTimespStr;
}

- (NSString *)timeStampOtherToDateInterval:(NSTimeInterval)times
{
    //    NSTimeInterval time = [timeStamp floatValue] / 1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"]; // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:times];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    DLOG(@"confromTimespStr =  %@",confromTimespStr);
    return confromTimespStr;
}

+ (NSString *)getOrderWithInter:(NSTimeInterval)interval
{
    NSString *time = [[APPHelper shareAppHelper] timeStampOtherToDateInterval:interval];
    return time;
}


+ (NSString *)getDateWithInter:(NSTimeInterval)interval
{
    NSString *time = [[APPHelper shareAppHelper] timeStampToDateInterval:interval];
    return time;
}

- (NSString *)kNumWithNumber:(NSString*)nums
{
    NSString *num = nums;
    if (nums.length >= 5)
    {
        num = [NSString stringWithFormat:@"%d%dk",nums.intValue / 10000 ,nums.intValue % 10000 / 1000];
    }
    return num;
}

//- (NSString *)currentDeviceUUID
//{
//    //从default里获取
//    NSString *uuid = @"";
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    if (standardUserDefaults)
//    {
//        uuid = [standardUserDefaults objectForKey:kWhatsLiveUUID];
//    }
//    
//    if (uuid && ![uuid isEqualToString:@""])
//    {
//        return uuid;
//    }
//    
//    //从keychain里获取
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
//    NSString *keyChainUUID = [keychainItem objectForKey:(__bridge id)kSecValueData];
//    
//    //都获取不到值的情况，重新创建
//    if ([keyChainUUID isEqualToString:@""])
//    {
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//        keyChainUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
//        [keychainItem setObject:@"LESHOOT_IPHONE_CLIENT_UUID" forKey:(__bridge id)kSecAttrService];
//        [keychainItem setObject:keyChainUUID forKey:(__bridge id)kSecValueData];
//        
//        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//        if (standardUserDefaults && keyChainUUID != nil)
//        {
//            [standardUserDefaults setObject:keyChainUUID forKey:kWhatsLiveUUID];
//            [standardUserDefaults synchronize];
//        }
//    }
//    
//    //keychain里的为空，获取default里的
//    return keyChainUUID;
//}

- (UIViewController *)getCurrentViewController
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (BOOL)isChinaLanguage
{
    return YES;
    BOOL isChinese;
    if ([[APPHelper getCurrentLanguage] isEqualToString:@"zh-Hans"] || [[APPHelper getCurrentLanguage] isEqualToString:@"zh-Hans-CN"]) {
        isChinese = YES;
    }
    else{
        isChinese = NO;
    }
    return isChinese;
}

//按比例压缩图片
+ (NSData *)compressionImage:(NSString *)imageURL
{
    NSData *oldData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    UIImage *image = [UIImage imageWithData:oldData];
    NSData *newData = UIImageJPEGRepresentation(image, kCompressionQuality);
    return newData;
}

//压缩图片到指定大小
+ (NSData *)compressionImageToSize:(CGSize)size WithImageURL:(NSString *)imageURL
{
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImageJPEGRepresentation(scaledImage, 1);
    return data;
}

//计算时间差
+ (NSString *)timesDifferenceWithEndDate:(NSDate *)endDate startDate:(NSDate *)startDate
{
    NSTimeInterval interval = [endDate timeIntervalSinceDate:startDate];
    return [NSString stringWithFormat:@"%f",interval * 1000];
}

//判断字符串中是否含有Emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (BOOL)isShouldChangeTextViewWithStr:(NSString *)str maxCount:(NSInteger)maxCount range:(NSRange)range text:(NSString *)text textView:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    NSInteger count = [APPHelper countTheStrLength:textView.text];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < maxCount) {
            return YES;
        }
        else
        {
            return NO;
        }
    } else {
        
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = maxCount - comcatstr.length;
    
    if (count > maxCount){
        NSString *str = textView.text;
        textView.text = [self substringWithString:str MaxNumber:maxCount];
    }
    return YES;

}


+ (BOOL)isShouldChangeTextFiledWithStr:(NSString *)str maxCount:(NSInteger)maxCount range:(NSRange)range text:(NSString *)text textField:(UITextField *)textField
{
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textField positionFromPosition:selectedRange.start offset:0];
    NSInteger count = [APPHelper countTheStrLength:textField.text];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < maxCount)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    } else
    {
    }
    if (count > maxCount)
    {
        NSString *str = textField.text;
        textField.text = [APPHelper substringWithString:str MaxNumber:maxCount];
    }
    return YES;
    
}


+ (NSString *)substringWithString:(NSString *)string MaxNumber:(int)number{
    NSString *str = string;
    float maxNumber = 0;
    int maxIndex = 0;
    
    for (int i = 0; i < string.length; i++) {
        NSString *test = [string substringWithRange:NSMakeRange(i, 1)];
        if ([test canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            DLOG(@"=====1");
            maxNumber += 0.5;
        }else{
            //中文或表情
            DLOG(@"-----0");
            maxNumber += 1;
        }
        maxIndex++;
        if (maxNumber >= maxIndex) {
            DLOG(@"maxNumber = %f, maxIndex = %d",maxNumber,maxIndex);
            break;
        }
    }
    str = [str substringToIndex:maxIndex];
    return str;
}

//统计字符个数新方法(陈誉洋)
+ (int)countStringLength:(NSString *)strtemp{
    __block int countNumber = 0;
    [strtemp enumerateSubstringsInRange:NSMakeRange(0, [strtemp length])
                                options:NSStringEnumerationByComposedCharacterSequences
                             usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                 if ([substring canBeConvertedToEncoding:NSASCIIStringEncoding])
                                 {
                                     countNumber +=1;
                                 }
                                 else
                                 {
                                     countNumber +=2;
                                 }
                             }];
    return countNumber;
}

+ (NSString *)newStringWithStr:(NSString *)str
                    totalCount:(NSInteger)totalCount
                     hasLength:(NSInteger)hasLength
{
    __block int originLength = hasLength;
    int orignCount = [APPHelper countStringLength:[str substringToIndex:hasLength]];
    __block int maxCount = totalCount - orignCount;
    [str enumerateSubstringsInRange:NSMakeRange(originLength, [str length] - originLength) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        if (maxCount <= 0)
        {
            // return [str substringToIndex:self.numberOfCount];
        }
        else
        {
            if ([substring canBeConvertedToEncoding:NSASCIIStringEncoding]) {
                maxCount -= 1;
            }
            else
            {
                maxCount -= 2;
            }
            originLength ++;
        }
        
        
    }];
    return [str substringToIndex:originLength];
}

+ (NSString *)newNumWithNums:(NSString*)nums
{
    NSString *num = nums;
    if (nums.length >= 5)
    {
        num = [NSString stringWithFormat:@"%d%dk",nums.intValue / 10000 ,nums.intValue % 10000 / 1000];
    }
    return num;
}


+ (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

+ (BOOL)isValidatIP:(NSString *)ipAddress
{
    
    NSString  *urlRegEx =@"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:ipAddress];
}


+ (NSString *)describeTimeWithMSec:(NSString *)twsj
{
    if (!twsj) {
        return @"";
    }
    
    long long curTimeMSec = (long long)([NSDate date].timeIntervalSince1970*1000);
    long long passTimeSec = (curTimeMSec - [twsj longLongValue])/1000;

    //异常错误
    if (passTimeSec < 0) {
        return @"";
    }
    
    //分
    NSUInteger mins = (NSUInteger)(passTimeSec/60);
    if (!mins) {
        return [NSString stringWithFormat:@"%lld秒钟前",passTimeSec];
    }
    //小时
    NSUInteger hours = (NSUInteger)(mins/60);
    if (!hours) {
        return [NSString stringWithFormat:@"%u分钟前",mins];
    }
    
    NSUInteger days = hours/24;
    if (!days) {

        return [NSString stringWithFormat:@"%u小时前",hours];
    }
    
    NSUInteger years = days/365;
    if (!years) {
        return [NSString stringWithFormat:@"%u天前",days];
    }
    else{
        return [NSString stringWithFormat:@"%u年前",years];
    }
}

@end
