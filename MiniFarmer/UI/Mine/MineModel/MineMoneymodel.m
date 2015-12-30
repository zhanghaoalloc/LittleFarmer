//
//  MineMoneymodel.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineMoneymodel.h"

@implementation MineMoneymodel
-(void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    
    self.recodid = [jsonDic objectForKey:@"id"];

}



@end
