//
//  JudgeTextIsRight.h
//  Lepai
//
//  Created by 尹新春 on 14-11-22.
//  Copyright (c) 2014年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用来判断给定的字符串是否正确
 */
@interface JudgeTextIsRight : NSObject
/**
 *  用来判断电话号码是否正确
 *
 *  @param mobileNum 传入的电话号码
 *
 *  @return 返回是否正确
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 *  判断输入的密码是否是6-16位 字母 数字 和特殊符号组成
 *
 *  @param PWD 出入的密码
 *
 *  @return 是否正确
 */
+ (BOOL)isRightPWDNumber:(NSString *)PWDNumber;

/**
 *  判断输入的邮箱是否正确
 *
 *  @param Email 输入的邮箱
 *
 *  @return 是否正确
 */
+ (BOOL)isRightEmail:(NSString *)Email;
@end
