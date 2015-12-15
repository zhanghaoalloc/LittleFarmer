//
//  JudgeTextIsRight.m
//  Lepai
//
//  Created by 尹新春 on 14-11-22.
//  Copyright (c) 2014年 Letv. All rights reserved.
//

#import "JudgeTextIsRight.h"

@implementation JudgeTextIsRight
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //     NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //    NSString *regex = @"^(1)\\D{10}";
    NSString *regex = @"^(1)\\d{10}$";
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    NSPredicate *regextestct1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if(([regextestmobile
         evaluateWithObject:mobileNum]==YES)
       ||([regextestcm evaluateWithObject:mobileNum]==YES)
       ||([regextestct evaluateWithObject:mobileNum]==YES)
       ||([regextestcu evaluateWithObject:mobileNum]==YES)
       ||([regextestct1 evaluateWithObject:mobileNum]==YES))
    {
        return YES;
        
    }
    else
    {
        return NO;
    }

}
+ (BOOL)isRightPWDNumber:(NSString *)PWDNumber
{
    /**
     *  判断输入的是6-16位字符或者数字
     */
    NSString * regex = @"^[A-Za-z0-9]{6,16}$";
    NSString * regex1 = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(([pred
         evaluateWithObject:PWDNumber]==YES)
       ||([pred1 evaluateWithObject:PWDNumber]==YES))
    {
        return YES;
    }
    return NO;
    /**
     *  三者必须同时的
     @"^(?![a-zA-Z0-9]+$)(?![^a-zA-Z/D]+$)(?![^0-9/D]+$).{10,20}$";
     */

}

+ (BOOL)isRightEmail:(NSString *)Email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:Email];
}

@end
