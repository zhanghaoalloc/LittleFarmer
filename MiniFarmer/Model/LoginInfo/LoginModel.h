//
//  LoginModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@interface Rows : JSONModel

@property (nonatomic, copy) NSString <Optional> *userId;
@property (nonatomic, copy) NSString <Optional> *mobile;
@property (nonatomic, copy) NSString <Optional> *usertx;
@property (nonatomic, copy) NSString <Optional> *username;
@property (nonatomic, copy) NSString <Optional> *password;
@property (nonatomic, copy) NSString <Optional> *location;
@property (nonatomic, copy) NSString <Optional> *nzdid;
@property (nonatomic, copy) NSString <Optional> *zjid;


@end

@interface LoginModel : BaseModel

@property (nonatomic, strong) Rows <Optional> *rows;

@end
