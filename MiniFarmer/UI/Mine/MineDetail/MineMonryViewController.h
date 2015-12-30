//
//  MineMonryViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"
#import "MineInfos.h"

@interface MineMonryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)MineInfos *infos;


@end
