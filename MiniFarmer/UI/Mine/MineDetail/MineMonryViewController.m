//
//  MineMonryViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineMonryViewController.h"
#import "UserInfo.h"
#import "MineMoneyView.h"
#import "BaseViewController+Navigation.h"
#import "MineMoneymodel.h"
#import "MineMoneyrecodCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface MineMonryViewController ()

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MineMonryViewController{

    NSString *_identify;
    MineMoneyView *_mymoneView;
    NSMutableArray *data;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.edgesForExtendedLayout = UIRectEdgeAll;
   [ self setNavigationBarIsHidden:NO];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
   

    [self initTitleLabel:@"农人币详情"];
    
    [self initnavigationBack];

       
}
- (void)initnavigationBack{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLineToBarBottomWithColor:RGBCOLOR(169, 169, 169) heigth:0.5];
    
    [self.view addSubview:backButton];
}
- (void)viewWillAppear:(BOOL)animated{
    
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];

}
- (void)popVC{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)_createSubView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeigth+kStatusBarHeight, kScreenSizeWidth, kScreenSizeHeight-(kNavigationBarHeigth+kStatusBarHeight)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    _mymoneView = [[MineMoneyView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 174)];
    _mymoneView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _mymoneView.point = _infos.point;
    _tableView.tableHeaderView = _mymoneView;
    
    
    [self.view addSubview:_tableView];
    
    _identify =@"UITableViewCell";
    UINib *nib = [UINib nibWithNibName:@"MineMoneyrecodCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];
}
#pragma mark---UITableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return data.count;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMoneyrecodCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.model = data[indexPath.row];
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heigth = [tableView fd_heightForCellWithIdentifier:_identify configuration:^(MineMoneyrecodCell * cell) {
        cell.model = data[indexPath.row];
        
    }];


    return heigth;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenSizeWidth, 12)];
    view.backgroundColor = [UIColor colorAndAlphaWithHexString:@"#eeeeee"];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
    
}

#pragma mark--数据处理
- (void)setInfos:(MineInfos *)infos{

    _infos = infos;
    
    [self requestData];
    
}
- (void)requestData{
    
    data = [NSMutableArray array];
    
    
    NSString *userid = [UserInfo shareUserInfo].userId;
    
    NSDictionary *dic = @{
                          @"userid":userid,
                          @"username":_infos.xm
                          };
    __weak MineMonryViewController *wself =self;
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=user&m=get_point_log" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *code = [responseObject objectForKey:@"code"];
        
        if ([code integerValue]==1) {
            
            NSArray *array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in array) {
                MineMoneymodel *model = [[MineMoneymodel alloc] initContentWithDic:dic];
                [data addObject:model];
    
            }
            
            [wself _createSubView];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
@end
