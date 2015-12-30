//
//  MineExpertModel.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/23.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineExpertModel.h"

@implementation MineExpertModel
- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    
    self.zjid = [jsonDic objectForKey:@"id"];


}
@end
