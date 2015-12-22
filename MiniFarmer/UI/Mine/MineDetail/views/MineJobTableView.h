//
//  MineJobTableView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMenuItem.h"
typedef void(^SelectBlock)(NSString *jobName) ;
@interface MineJobTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,strong)UserMenuItem *item;

@property(nonatomic,copy)SelectBlock block;

@end
