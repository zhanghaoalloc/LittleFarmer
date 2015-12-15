//
//  MyRecipeModel.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyRecipeModel.h"

@implementation MyRecipeList

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id" : @"listId"}];
}

@end

@implementation MyRecipeModel

@end
