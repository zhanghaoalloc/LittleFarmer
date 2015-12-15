//
//  MyAskQuestionModel.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyAskQuestionModel.h"

@implementation MyAskQuestionModel

@end

@implementation MyAskQuestionList

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id" : @"listId"}];
}



@end