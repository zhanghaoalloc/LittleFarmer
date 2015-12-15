//
//  StudyModel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface StudyModel : MyModel

@property(nonatomic,copy)NSString *twoclassname;
@property(nonatomic,copy)NSString *twoclassid;
@property(nonatomic,strong)NSArray *zplist;

@end
