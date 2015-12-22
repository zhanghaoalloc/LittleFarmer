//
//  MethodModel.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/15.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MethodModel.h"

@implementation MethodModel

- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    
    self.pfid = [jsonDic objectForKey:@"id"];


}


@end
