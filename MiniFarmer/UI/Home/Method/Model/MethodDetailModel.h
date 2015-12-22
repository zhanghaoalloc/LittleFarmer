//
//  MethodDetailModel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/11.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface MethodDetailModel : MyModel

@property (nonatomic,strong)NSString *xm;
@property (nonatomic,strong)NSURL *usertx;
@property (nonatomic,strong)NSString *zjid;
@property (nonatomic,strong)NSString *location;
@property (nonatomic,strong)NSString *pfid;
@property (nonatomic,strong)NSString *pfmc;
@property (nonatomic,strong)NSString *pfscsj;
@property (nonatomic,strong)NSString *pfms;
@property (nonatomic,strong)NSString *ddcs;
@property (nonatomic,strong)NSString *comments;
@property (nonatomic,strong)NSNumber *isdz;
@property (nonatomic,strong)NSArray *images;

@end
