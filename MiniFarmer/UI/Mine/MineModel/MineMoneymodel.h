//
//  MineMoneymodel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyModel.h"

@interface MineMoneymodel : MyModel
/*
 code = 1;
 count = 55;
 device = 1;
 list =     (
 {
 datetime = "2015-12-22 16:39:55";
 id = 85116;
 intro = "\U4e13\U5bb6\U56de\U7b54\U63d0\U95ee";
 memo = "\U8ba4\U8bc1\U4e13\U5bb6\U56de\U7b54\U63d0\U95ee\U79ef\U5206";
 "pointrule_id" = 5001;
 "user_id" = 202;
 value = 20;
 },
 */
@property(nonatomic,copy)NSString *datetime;
@property(nonatomic,copy)NSString *recodid;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *memo;
@property(nonatomic,copy)NSString *pointrule_id;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *value;




@end
