//
//  TwoclassMode.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "TwoclassMode.h"

@implementation TwoclassMode

- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    self.diseaid  = jsonDic[@"id"];



}

@end
