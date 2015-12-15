//
//  MineSaveTechnology.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSaveTechnology.h"

@implementation MineSaveTechnology

@end

@implementation MineSaveTechnologyList

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id" : @"listId"}];
}

@end