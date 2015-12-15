//
//  DieaseModel.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/30.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DieaseModel.h"

@implementation DieaseModel
- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    _bachid = jsonDic[@"id"];
    
    
    
}



@end
