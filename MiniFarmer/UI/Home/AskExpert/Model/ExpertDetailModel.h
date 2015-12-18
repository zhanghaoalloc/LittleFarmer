//
//  ExpertDetailModel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyModel.h"

@interface ExpertDetailModel : MyModel

/*
 code = 1;
 device = 2;
 friends = 0;
 grade = 0;
 hfcns = 2;
 icode = D907C;
 jsylx = "\U975e\U8ba4\U8bc1\U4e13\U5bb6";
 location = "\U4e2d\U56fd\U6e56\U5357\U7701\U957f\U6c99\U5e02";
 msg = success;
 point = 1040;
 sczwms = "\U7389\U7c73,\U9ad8\U7cb1,\U9a6c\U94c3\U85af";
 usertx = "http://www.enbs.com.cn/apps_2/uploads/zjimages/2015/11/17/14477488358352.jpg";
 utype = 0;
 xm = "\U9646\U7d6e";
 zjid = 152;
 zjlxid = 1007;
 zjlxms = "\U79d1\U7814\U4e00\U7ebf\U4e13\U5bb6";
 zjnl = 52;
 zzzw = "\U65e0";*/

@property(nonatomic,copy)NSNumber *friends;
@property(nonatomic,copy)NSNumber *grade;
@property(nonatomic,copy)NSString *hfcns;
@property(nonatomic,copy)NSString *icode;
@property(nonatomic,copy)NSString *jsylx;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *point;
@property(nonatomic,copy)NSString *sczwms;
@property(nonatomic,copy)NSString *usertx;
@property(nonatomic,copy)NSString *utype;
@property(nonatomic,copy)NSString *xm;
@property(nonatomic,copy)NSString *zjid;
@property(nonatomic,copy)NSString *zjlxms;
@property(nonatomic,copy)NSString *zjnl;
@property(nonatomic,copy)NSString *zzzw;




















@end
