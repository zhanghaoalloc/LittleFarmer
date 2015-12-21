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
#import "ExpertModel.h"


@interface ExpertSearchViewController ()
@property (nonatomic,strong) SeachView *searchView;
@property (nonatomic,strong) NSMutableArray *data;


@end

@implementation ExpertSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
   
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.data = [NSMutableArray array];
    //初始化导航栏
    [self setNavigation];
    
    [self _createSubView];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{

    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [appDelegate hideTabbar];
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
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight-0.5, kScreenSizeWidth,0.5 )];
    line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [_searchView addSubview:line];
}
- (void)back:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//创建子视图
- (void)_createSubView{
    _tableView = [[ExpertListTableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeight, kScreenSizeWidth, kScreenSizeHeight-(kNavigationBarHeight+kStatusBarHeight)) style:UITableViewStylePlain];
    _tableView.isSearch = YES;
    [self.view addSubview:_tableView];
}
- (void)setKeyWord:(NSString *)keyWord{
    _keyWord = keyWord;
    
    [self requestData];


}
- (void)requestData{
    
    NSDictionary *dic = @{
                          @"pagesize":@"10",
                          @"wd":_keyWord,
                          @"id":@"0"
                          };
    
    __weak ExpertSearchViewController *wself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=search&m=zj" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"code"];
        if ([code integerValue]==1) {//成功
            NSArray *array = [responseObject objectForKey:@"list"];
            
            for (NSDictionary *dic in array) {
                ExpertModel *model = [[ExpertModel alloc] initContentWithDic:dic];
                [self.data addObject:model];
            }
            
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                wself.tableView.data = wself.data.mutableCopy;
                
            });
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    





}




@end
