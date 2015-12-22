//
//  PfcommentModel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/15.
//  Copyright © 2015年 enbs. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface PfcommentModel : MyModel

@property (nonatomic,strong)NSString *hfid;
@property (nonatomic,strong)NSString *pfid;
@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *indatetime;
@property (nonatomic,strong)NSString *commenttext;
@property (nonatomic,strong)NSString *xm;
@property (nonatomic,strong)NSString *location;
@property (nonatomic,strong)NSURL *usertx;
@property (nonatomic,strong)NSNumber *landlord;
@property (nonatomic,strong)NSArray *replaylist;

@end
