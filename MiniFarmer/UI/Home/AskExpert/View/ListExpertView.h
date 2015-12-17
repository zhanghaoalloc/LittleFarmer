//
//  ListExpertView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSString *expertType,NSString *lxbh);

@interface ListExpertView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,copy)ClickBlock block;

@property(nonatomic,assign)BOOL isrigth;






@end
