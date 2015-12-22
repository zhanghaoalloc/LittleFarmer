//
//  PlantListModel.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "PlantListModel.h"

@implementation PlantListModel
- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    
    self.plantid = [jsonDic objectForKey:@"id"];

}

@end
