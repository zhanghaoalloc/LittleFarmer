//
//  ExpertDetailViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpertModel.h"


@interface ExpertDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSString *zjuserid;
@property(nonatomic ,strong)NSString *zjid;

@property(nonatomic,strong)ExpertModel *expertmodel;
@property(nonatomic,assign)BOOL isMineView;


@end
