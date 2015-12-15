
//
//  MineSaveQuestionModel.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSaveQuestionModel.h"

@implementation MineSaveQuestionModel

@end

@implementation MineSaveQuestionModelList

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id" : @"listId"}];
}

@end