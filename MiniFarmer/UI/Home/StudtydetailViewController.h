//
//  StudtydetailViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudtydetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSString  *bigid;

@end
