//
//  MineInfoViewController.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseViewController.h"
#import "MineInfos.h"
#import "ExpertModel.h"

@interface MineInfoViewController : MineBaseViewController

@property (nonatomic, strong) NSMutableArray *infos;

//普通用户的信息
@property (nonatomic, strong) MineInfos *info;

//专家用户的信息
@property (nonatomic ,strong)ExpertModel *model;

@property (nonatomic, assign)BOOL type;

@end
