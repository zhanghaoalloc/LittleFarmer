//
//  MIneExpertViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MIneExpertViewController.h"
#import "MineFoucsExpertCell.h"
#import "AskViewController.h"
#import "ExpertModel.h"
#import "ExpertListCell.h"
#import "ExpertDetailViewController.h"

@interface MIneExpertViewController ()

@property (nonatomic, strong) NSMutableArray *mineFocusExpertDataSource;

@end

@implementation MIneExpertViewController{

    NSString *_identify;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mineFocusExpertDataSource = [NSMutableArray array];
    
    [self _createSubView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];
    
    
}
- (void)_createSubView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , kScreenSizeWidth, kScreenSizeHeight-kStatusBarHeigth-kNavigationBarHeight-42) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _identify = @"ExpertCell";
    
    UINib *nib = [UINib nibWithNibName:@"ExpertListCell" bundle:nil];
    
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];
    
}
- (void)reloadData
{
    if (!self.mineFocusExpertDataSource.count)
    {
        [self requestInfoWithLastId:@"0"];
    }
}
- (void)requestInfoWithLastId:(NSString *)lastId
{
    //添加loading
    [self.view showLoadingWihtText:@"加载中..."];
    NSString *userId = [[MiniAppEngine shareMiniAppEngine] userId];
    NSDictionary *dic =@{
                         @"userid":[APPHelper safeString:userId]
                         
                         };
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet
    subUrl:@"?c=user&m=get_mygzzj_list"parameters:dic prepareExecute:nil
    success:^(NSURLSessionDataTask *task, id responseObject){
   
    //解析数据
    [self.view dismissLoading];
    [self cancelCurrentLoadAnimation];
    [self handleSucessWithResult:responseObject lastId:lastId];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    [self.view dismissLoading];
    [self cancelCurrentLoadAnimation];
    [self handleFailure];
    
    }];
}


- (void)handleSucessWithResult:(id)responseObject lastId:(NSString *)lastId
{     NSArray *array = [responseObject objectForKey:@"list"];
    
    for (NSDictionary *dic in array) {
        ExpertModel *model = [[ExpertModel alloc] initContentWithDic:dic];
        [self.mineFocusExpertDataSource addObject:model];
        
    }
    
    [self.tableView reloadData];
    
    
        if (!self.mineFocusExpertDataSource.count)
    {
        //这里显示无结果页
        [self.view showWeakPromptViewWithMessage:@"没有内容哦"];
    }
}

- (void)handleFailure
{
    [self.view showWeakPromptViewWithMessage:@"加载失败"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mineFocusExpertDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertListCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.model = self.mineFocusExpertDataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     ExpertDetailViewController *expertVC = [[ExpertDetailViewController alloc] init];
    ExpertModel *model = self.mineFocusExpertDataSource[indexPath.row];
    
     expertVC.zjid = model.userid;
     expertVC.expertmodel = model;
    
    [self.navigationController pushViewController:expertVC animated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

#pragma mark - 加载和刷新
- (void)loadMoreData
{
    MineExpertList *lastModel = [self.mineFocusExpertDataSource lastObject];
    [self requestInfoWithLastId:lastModel.listId];
}

- (void)pullToRefresh
{
    [self requestInfoWithLastId:@"0"];
}


@end
