//
//  MethodViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/7.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MethodViewController.h"
#import "BaseViewController+Navigation.h"
#import "SeachView.h"
#import "MethodViewCell.h"
#import "MJRefresh.h"
#import "MethodModel.h"
#import "MethodDetailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FabuViewController.h"

#define kPageSize   @"10"   //一次请求数据数

@interface MethodViewController ()

@property (nonatomic,strong)UITableView *methodTableView;
@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic,strong)UIButton *button;

@property (nonatomic,strong)UIButton *fbBtn;


@end
@implementation MethodViewController {
    
    SeachView *_searchView;
    

    NSString *_identify;

    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self requestdataWithPfid:@"0"];
    
  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"methodviewappear" object:nil];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(backBtnPressed)];
    
    
    //设置导航栏的搜索视图
    [self setNavigation];
    
    [self setNavigationBarIsHidden:NO];
    
    
    [self addSubViews];

//    [self requestdataWithPfid:@"0"];
}


//导航栏的设置
- (void)setNavigation {
    
    _searchView  = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    
    _searchView.frame = CGRectMake(50,kStatusBarHeight , kScreenSizeWidth-62,kNavigationBarHeigth);
    
    _searchView.imageNmae = @"home_btn_message_nm";
    
    [self.view addSubview:_searchView];
    
}

//添加子视图
- (void)addSubViews {
    
    //发布配方
    _fbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _fbBtn.frame = CGRectMake(kScreenSizeWidth - 90, kScreenSizeHeight - 100, 60, 60);
    
    [_fbBtn setImage:[UIImage imageNamed:@"write_recipe"] forState:UIControlStateNormal];
    
    [_fbBtn addTarget:self action:@selector(fabuAct) forControlEvents:UIControlEventTouchUpInside];

   
    
    
    //返回顶部按钮
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(kScreenSizeWidth-85, kScreenSizeHeight - 160, 50, 50);
    
    [_button setImage:[UIImage imageNamed:@"go_top"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(totop) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
    _methodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight) style:UITableViewStylePlain];
    
    self.methodTableView.dataSource = self;
    self.methodTableView.delegate = self;
    
    _methodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.methodTableView];
    [self.view addSubview:_fbBtn];
    [self.view addSubview:_button];
    _methodTableView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];

    
    _identify   = @"MethodViewCell";
    
    UINib *nib =  [UINib nibWithNibName:@"MethodViewCell" bundle:nil];
    
    [_methodTableView registerNib:nib forCellReuseIdentifier:_identify];
    
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestdataWithPfid:@"0"];
        
    }];
    
    _methodTableView.header = mjHeader;
    
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    
    _methodTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (_data == 0) {
            return ;
        }
        MethodModel *methodId = [_data lastObject];
        
        [self requestdataWithPfid:methodId.pfid];
    }];
}

//请求数据
- (void)requestdataWithPfid: (NSString *)pfid{
    
    if (_data == nil) {
        
        _data = [NSMutableArray array];
        
    }
    
    
    NSDictionary *dicPar = @{
                             @"pfid":@0,
                             
                             @"pagesize":kPageSize,
                             
                             };
    
    __weak MethodViewController *wself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=wzpf&m=getfplist" parameters:dicPar prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_methodTableView.header endRefreshing];
        [_methodTableView.footer endRefreshing];
        
        if (!responseObject) {
            return ;
        }
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *result = responseObject;
            
            BOOL code = [[result objectForKey:@"code"] boolValue];
            NSString *msg = [result objectForKey:@"msg"];
            DLOG(@"code = %d,msg = %@",code,msg);
            if (!code) {
                //显示加载错误提示
                return;
            }
            else{
                //加载数据成功
                NSMutableArray *array = responseObject[@"list"];
                
                for (NSDictionary *dic in array) {
                    
                    MethodModel *model = [[MethodModel alloc] initContentWithDic:dic];
                    
                    [wself.data addObject:model];
                    
                 }
                                
            [wself.methodTableView reloadData];

            }

        }

        
        return ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_methodTableView.header endRefreshing];
        [_methodTableView.footer endRefreshing];
        
    }];
    
}

//返回顶部

- (void)totop{
    
    [self.methodTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

//返回按钮
- (void)backBtnPressed{
    
    [self.navigationController popToRootViewControllerAnimated:YES];

    
}


//发布按钮
- (void)fabuAct{
    
    FabuViewController *fabuVC = [[FabuViewController alloc] init];
    [self.navigationController pushViewController:fabuVC animated:YES];
    
}
#pragma mark - UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MethodViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    
    
    cell.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    cell.model = _data[indexPath.row];
    
    return cell;
}

//返回单元格的高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heigth =[tableView fd_heightForCellWithIdentifier:_identify configuration:^(MethodViewCell * cell) {
        
        cell.model = _data[indexPath.row];
        
    }];
    
    return   heigth;
    
}

//单元格点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MethodDetailViewController *detaliVC = [[MethodDetailViewController alloc] init];
    

    self.pfID = _data[indexPath.row];
    
    [self.navigationController pushViewController:detaliVC animated:YES];
}


@end
