//
//  QusetionSearchViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/3.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"

@interface QusetionSearchViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSString *keyword;
@property(nonatomic,assign)BOOL isSearch;


@end
