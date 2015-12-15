//
//  QuestionInfo.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionInfo.h"

@implementation QuestionInfo

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"qid",
                                                       }];
}
@end
