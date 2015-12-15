//
//  MineExpertInfo.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineExpertInfo.h"

@implementation MineExpertInfo

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id" : @"infoid"}];
}

@end
