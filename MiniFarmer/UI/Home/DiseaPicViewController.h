//
//  DiseaPicViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"

@interface DiseaPicViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>



@property(nonatomic,copy)NSString *twoclassid;

@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,copy)NSString *keyword;

@end
