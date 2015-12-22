//
//  MethodModel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/15.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"
@interface MethodModel : MyModel

@property (nonatomic,copy)NSString *xm;
@property (nonatomic,copy)NSURL *usertx;
@property (nonatomic,copy)NSString *zjid;
@property (nonatomic,copy)NSString *location;
@property (nonatomic,strong)NSString *pfid;
@property (nonatomic,copy)NSString *pfmc;
@property (nonatomic,assign)NSInteger *tag;
@property (nonatomic,copy)NSString *pfscsj;
@property (nonatomic,copy)NSString *bigclassid;
@property (nonatomic,copy)NSString *bigclassname;
@property (nonatomic,copy)NSString *twoclassid;
@property (nonatomic,copy)NSString *twoclassname;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *pfms;
@property (nonatomic,copy)NSString *ddcs;
@property (nonatomic,assign)NSInteger *commentcs;
@property (nonatomic,assign)NSNumber *imgcolumns;
@property (nonatomic,copy)NSArray *images;
@end
