//
//  ExpertListTableView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ExpertListTableView.h"
#import "ExpertListCell.h"
#import "ExpertModel.h"
#import "UIViewAdditions.h"
#import "ExpertDetailViewController.h"

@implementation ExpertListTableView{

    NSString *_identify ;

}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initSubView];
    }
    return self;
}
- (void)_initSubView{
    
    self.delegate = self;
    self.dataSource = self;
    
    _identify = @"expertlistCell";
    //注册单元格
    UINib * nib = [UINib nibWithNibName:@"ExpertListCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:_identify];
   
}
#pragma mark -----数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;

}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpertListCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    ExpertModel *model = self.data[indexPath.row];
    cell.model =model;

    
    return cell;
}
#pragma mark----协议方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpertDetailViewController *expertVC = [[ExpertDetailViewController alloc] init];
    self.viewController.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self.viewController.navigationController pushViewController:expertVC animated:YES];




}
#pragma mark---数据处理
- (void)setData:(NSArray *)data{

    _data = data;
    
    CGRect frame = self.frame;
    
    CGFloat heigth = _data.count*150;
    if (heigth<frame.size.height) {
        frame.size.height = heigth;
        self.frame = frame;
    }else{
        frame.size.height =  kScreenSizeHeight-(kNavigationBarHeight+kStatusBarHeight+44);
        self.frame = frame;
        
    
    }
    
    [self reloadData];

}

@end
