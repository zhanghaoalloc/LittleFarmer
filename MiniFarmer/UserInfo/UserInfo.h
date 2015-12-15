//
//  UserInfo.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *zjid;
@property (nonatomic, assign) BOOL isSaveUserName;
@property (nonatomic, assign) BOOL isLogin;

+ (UserInfo *)shareUserInfo;


@end
