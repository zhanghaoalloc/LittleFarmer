//
//  SearchViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SearchViewController.h"
#import "SeachView.h"
#import "SortView.h"
#import "UIView+FrameCategory.h"
#import "QusetionSearchViewController.h"
#import "DiseaPicViewController.h"
#import "BaseViewController+Navigation.h"


@interface SearchViewController ()

@end

@implementation SearchViewController{
    SeachView *_seachView;
    UITextField * _subtext;
    
    SortView *_sortView;
    
    
    UITableView *_tableView;
    UIView *_tableFooterView;
    NSMutableArray *_history;
    
    NSString *identify;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
    if (_history == nil) {
        _history = [NSMutableArray array];
    }
    NSMutableArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:KHistory];
    _history = [NSMutableArray arrayWithArray:array];
    
    /*
         CGRect frame = _tableView.frame;
         frame.size.height = 170;
         _tableView.frame = frame;
     */
    
    if (_history.count!= 0) {
        _tableView.hidden = NO;
    }else{
        _tableView.hidden = YES;

    }
    
    CGRect frame = _tableFooterView.frame;
    frame.size.height = _tableView.height-_history.count*44;
    _tableFooterView.frame = frame;
    
    [_tableView reloadData];
     

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _CreateSubView];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self setNavigationBarIsHidden:NO];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    //设置导航栏的分割线
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#eeeeee"] heigth:1];

    

    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:_history forKey:KHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)_CreateSubView{
    //1.搜索栏
    _seachView = [[NSBundle mainBundle]loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    // _seachView.backgroundColor = [UIColor redColor];
    _seachView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _seachView.frame = CGRectMake(0,kStatusBarHeight,kScreenSizeWidth , kNavigationBarHeight);
    _seachView.imageNmae = nil;
    _seachView.title = @"取消";
    _seachView.isSearch = YES;
    
    
    UIView *textView = (UIView *)[_seachView viewWithTag:101];
    _subtext = (UITextField *)[textView viewWithTag:201];
    _subtext.delegate = self;
    
    
    /*
    [_seachView textFileString:^(NSString *text) {
        
        [_history addObject:text];
        
    }];
     */
    
    

    [self.view addSubview:_seachView];
    
    //2.分类栏
    _sortView = [[NSBundle mainBundle]loadNibNamed:@"SortView" owner:self options:nil].lastObject;
    _sortView.frame = CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth, 120);
    _sortView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _sortView.currentIndex = _index;
    [self.view addSubview:_sortView];
    

    

    

    //3.历史记录
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _sortView.bottom,kScreenSizeWidth,kScreenSizeHeight-_sortView.frame.origin.y-kBottomTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        identify = @"tableviewcell";
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
        
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 150)];
        //_tableFooterView.backgroundColor = [UIColor redColor];
       

        [self clearHistory];
        
        [self.view addSubview:_tableView];
         _tableView.tableFooterView = _tableFooterView;

    }
   
}
- (void)clearHistory{

    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    [clear setBackgroundImage:[UIImage imageNamed:@"home_search_clearbtn"] forState:UIControlStateNormal];
    clear.frame = CGRectMake(_tableFooterView.height/2-65.5, 16, 131, 43);
    [clear setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [clear setTitleColor:[UIColor colorWithHexString:@"#ff6633"] forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    clear.titleLabel.font = kTextFont14;
    [_tableFooterView addSubview:clear];
    UIView *superView = _tableFooterView;
    
    [clear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(16);
        make.width.equalTo(@131);
        make.height.equalTo(@43);
        make.left.equalTo(superView.mas_left).offset(kScreenSizeWidth/2-65.5);
        
    }];
    
    
}
- (void)clearAction:(UIButton *)buttton{
    
    _tableView.hidden = YES;


    _history = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_tableView reloadData];
    


}
- (void)setIndex:(NSInteger)index{
    _index = index;
  


}

#pragma mark ---- UITableView的协议协议和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _history.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.textLabel.text = _history[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = kTextFont14;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
    if (_sortView.currentIndex == 3) {
        
        
        DiseaPicViewController *diseVC = [[DiseaPicViewController alloc] init];
        diseVC.keyword  = str;
        diseVC.isSearch = YES;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:diseVC animated:YES];
    }
    if (_sortView.currentIndex == 1) {
        QusetionSearchViewController *qusetionVC = [[QusetionSearchViewController alloc] init];
        qusetionVC.keyword = str;
        qusetionVC.isSearch = YES;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qusetionVC animated:YES];
    }
    
   
}
//UITableView开始滑动
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
   //使视图上的所有有文本编辑的视图的键盘都收起来
    [self.view endEditing:YES];

}

/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return _tableFooterView;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return  170;
}
 */


#pragma mark-----UITextFiled协议
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *keyword = textField.text;
    
    NSInteger index = _sortView.currentIndex;
    
    
    if (keyword.length == 0) {
        return YES;
    }
        
    [_history insertObject:keyword atIndex:0];
    if (index == 3) {
        DiseaPicViewController *diseVC = [[DiseaPicViewController alloc] init];
        diseVC.keyword  = textField.text;
        diseVC.isSearch = YES;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:diseVC animated:YES];
        
    }
    if (index == 1) {
        QusetionSearchViewController *qusetionVC = [[QusetionSearchViewController alloc] init];
        qusetionVC.keyword = textField.text;
        qusetionVC.isSearch = YES;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qusetionVC animated:YES];
        
    }
    
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
