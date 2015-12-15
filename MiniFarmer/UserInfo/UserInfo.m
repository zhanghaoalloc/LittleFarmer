//
//  UserInfo.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "UserInfo.h"
#import <objc/runtime.h>

NSString *const kUserName = @"userName";
NSString *const kUserId = @"userId";
NSString *const kZJId = @"zjid";

NSString *const kIsLogin = @"isLogin";
NSString *const kIsSaveNumber = @"isSaveNumber";

static UserInfo *userInfo;


@implementation UserInfo

+ (UserInfo *)shareUserInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UserInfo alloc] init];
    });
    return userInfo;
}


//编码的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:kUserName];
    [aCoder encodeObject:self.userId forKey:kUserId];
    [aCoder encodeObject:self.zjid forKey:kZJId];
    [aCoder encodeBool:self.isLogin forKey:kIsLogin];
    [aCoder encodeBool:self.isSaveUserName forKey:kIsSaveNumber];

}

//解码的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        NSString *userName = [aDecoder decodeObjectForKey:kUserName];
        NSString *userId = [aDecoder decodeObjectForKey:kUserId];
        NSString *zjid = [aDecoder decodeObjectForKey:kZJId];
        BOOL isLogin = [aDecoder decodeBoolForKey:kIsLogin];
        BOOL isSaveNumber = [aDecoder decodeBoolForKey:kIsSaveNumber];
        
        self.userName = userName;
        self.userId = userId;
        self.zjid = zjid;
        self.isLogin = isLogin;
        self.isSaveUserName = isSaveNumber;
    }
    
    return self;
}





@end
