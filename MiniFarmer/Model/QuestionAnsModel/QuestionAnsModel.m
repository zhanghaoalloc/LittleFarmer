//
//  QuestionAnsModel.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/15.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionAnsModel.h"

@implementation ReplyModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"ansid",
                                                       }];
}

@end

@implementation QuestionAnsModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"ansid",
                                                       }];
}

@end

