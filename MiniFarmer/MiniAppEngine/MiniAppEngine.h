//
//  MiniAppEngine.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/3.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiniAppEngine : NSObject

+ (MiniAppEngine *)shareMiniAppEngine;

#pragma mark - 设置
- (void)saveUserId:(NSString *)userId;

- (void)saveLogin;

//保存密码
- (void)saveUserLoginNumber:(NSString *)number;


//清除用户信息
- (void)clearUserLoginInfos;

//是否保存用户名
- (void)setSaveNumber:(BOOL)saveNumber;

#pragma mark - 获取

///是否登陆
- (BOOL)isLogin;

///获取用户的用户名
- (NSString *)userLoginNumber;
//是否保存了用户名
- (BOOL)isHasSaveUserLoginNumber;

- (NSString *)userId;

#pragma mark - 存入本地和从本地中读取

- (void)saveInfos;
- (void)getInfos;

- (NSString *)documentPath;

- (NSString *)userInfoPath;



@end
