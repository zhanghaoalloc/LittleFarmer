//
//  ExpertListTableView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertListTableView : UITableView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,assign)BOOL isSearch;

@end
