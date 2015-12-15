//
//  LoginModel.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

@end

@implementation Rows

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id" : @"userId"}];
}


@end