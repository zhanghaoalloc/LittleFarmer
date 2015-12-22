//
//  MethodViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/7.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"

@interface MethodViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSString *pfID;

@end
