//
//  ExpertModel.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ExpertModel.h"

@implementation ExpertModel
- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    self.zjid = [jsonDic objectForKey:@"id"];

}

@end
