//
//  SearchViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic,assign)NSInteger index;

@end
