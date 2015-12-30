//
//  MineExpertModel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/23.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyModel.h"

@interface MineExpertModel : MyModel

/*
 grade = 0;
 id = 107;
 sczwms = "\U6c34\U7a3b";
 userid = 42;
 usertx = "zjimages/107/ZM_14423640763218.jpg";
 xm = "\U80e1\U96c1";
 zjlxms = "\U690d\U4fdd\U7cfb\U7edf\U4e13\U5bb6";
 */
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *zjid;
@property(nonatomic,copy)NSString *sczwms;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *usertx;
@property(nonatomic,copy)NSString *xm;
@property(nonatomic,copy)NSString *zjlxms;



@end
