//
//  MiniAppEngine.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/3.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MiniAppEngine.h"
#import "UserInfo.h"

#define kUserLoginNumber @"userLoginNumber"
#define kIsSaveUserLoginNumber @"isSaveUserLoginNumber"
#define kUserInfo @"userInfo"

#define kUserId @"userId"

static MiniAppEngine *miniAppEngine;

@implementation MiniAppEngine

+ (MiniAppEngine *)shareMiniAppEngine
{
   static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miniAppEngine = [[MiniAppEngine alloc] init];
    });
    return miniAppEngine;
}

- (void)saveUserId:(NSString *)userId
{
    [UserInfo shareUserInfo].userId = userId;
}

- (void)saveUserLoginNumber:(NSString *)number
{
    [UserInfo shareUserInfo].userName = number;
}

- (void)clearUserNumber
{
    [UserInfo shareUserInfo].userName = nil;
}

- (void)clearUserLoginInfos
{
    [UserInfo shareUserInfo].userId = nil;
    [UserInfo shareUserInfo].isLogin = NO;
}

- (void)saveLogin;
{
    [UserInfo shareUserInfo].isLogin = YES;
}


- (void)setSaveNumber:(BOOL)saveNumber
{
    
    [UserInfo shareUserInfo].isSaveUserName = saveNumber;
    if (!saveNumber)
    {
        [self clearUserNumber];
    }
}


- (NSString *)userLoginNumber
{
    return [UserInfo shareUserInfo].userName;
}

- (NSString *)userId
{
    return [UserInfo shareUserInfo].userId;
}

- (BOOL)isHasSaveUserLoginNumber
{
    return [UserInfo shareUserInfo].isSaveUserName;
}

- (BOOL)isLogin
{
    if (![UserInfo shareUserInfo].isLogin)
    {
        return NO;
    }
    return YES;
}


- (void)saveInfos
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:[UserInfo shareUserInfo] forKey:kUserInfo];
    [archiver finishEncoding];

    [data writeToFile:[self userInfoPath] atomically:YES];
    
    
}
- (void)getInfos
{
    NSData *data = [NSData dataWithContentsOfFile:[self userInfoPath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    UserInfo *info = [unarchiver decodeObjectForKey:kUserInfo];
    [unarchiver finishDecoding];
    
    //有时间可以研究属性列表 然后用属性列表来实现
    [UserInfo shareUserInfo].userId = info.userId;
    [UserInfo shareUserInfo].userName = info.userName;
    [UserInfo shareUserInfo].isLogin = info.isLogin;
    [UserInfo shareUserInfo].zjid = info.zjid;
    [UserInfo shareUserInfo].isSaveUserName = info.isSaveUserName;
}

- (NSString *)userInfoPath
{
    return [[self documentPath] stringByAppendingPathComponent:@"UserInfos"];
}

- (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

@end
