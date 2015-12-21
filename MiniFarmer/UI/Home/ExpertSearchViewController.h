//
//  ExpertSearchViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/20.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpertListTableView.h"

@interface ExpertSearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)ExpertListTableView *tableView;
@property(nonatomic,copy)NSString *keyWord;

@end
