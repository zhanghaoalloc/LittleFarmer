//
//  ExpertSearchViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/20.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ExpertSearchViewController.h"
#import "SeachView.h"
#import "BaseViewController+Navigation.h"


@interface ExpertSearchViewController ()
@property (nonatomic,strong) SeachView *searchView;


@end

@implementation ExpertSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    //初始化导航栏
    [self setNavigation];
    
    [self _createSubView];
    
    
    
}
- (void)setNavigation{
    //1.搜索栏
    _searchView  = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    _searchView.frame = CGRectMake(35,kStatusBarHeight , kScreenSizeWidth-35,kNavigationBarHeigth);
    _searchView.imageNmae = @"home_btn_message_nm";
    _searchView.isSearch = NO;
    _searchView.index = 4;
    
    [self.view addSubview:_searchView];
    
    //2.导航栏返回按钮
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    //3.导航栏底部分割线
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#eeeeee"] heigth:0.5];
}
- (void)back:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//创建子视图
- (void)_createSubView{
    _tableView = [[ExpertListTableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeight, kScreenSizeWidth, kScreenSizeHeight-(kNavigationBarHeight+kStatusBarHeight)) style:UITableViewStylePlain];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
