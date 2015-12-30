//
//  MIneExpertViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MIneExpertViewController.h"

#import "AskViewController.h"
#import "ExpertListCell.h"
#import "MineExpertModel.h"
#import "NetfailureView.h"

#import "ExpertDetailViewController.h"

@interface MIneExpertViewController ()

//列表的专家Model
@property (nonatomic, strong) NSMutableArray *mineFocusExpertDataSource;
//专家详情的Model


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
    BOOL status =[[SHHttpClient defaultClient] isConnectionAvailable];
    if (status == NO) {
        [self NetWorkingfaiure];
        return;
    }
    //添加loading
    [self.view showLoadingWihtText:@"加载中..."];
    NSString *userId = [[MiniAppEngine shareMiniAppEngine] userId];
    NSDictionary *dic =@{
                         @"userid":[APPHelper safeString:userId],
                         @"id":lastId,
                         @"pagesize":@"10"
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
{
    NSArray *array = [responseObject objectForKey:@"list"];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in array) {
        ExpertModel *model = [[ExpertModel alloc] initContentWithDic:dic];
        [dataArray addObject:model];
    }
    if (!self.mineFocusExpertDataSource) {
        self.mineFocusExpertDataSource = [NSMutableArray arrayWithArray:dataArray];
    }
    
    if (array.count) {
        if (lastId.intValue) {
            [self.mineFocusExpertDataSource removeAllObjects];
        }
        [self.mineFocusExpertDataSource addObjectsFromArray:dataArray];
    }
    
    [self noMoreData:array.count<10];
    
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
- (void)loadMoreData{
    [self requestInfoWithLastId:[self relyExpertModel].zjid];

}
- (ExpertModel *)relyExpertModel{
  
    return _mineFocusExpertDataSource.lastObject;
   

}
#pragma mark-----UITaleViewdelagate
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
    expertVC.zjuserid = model.userid;
     expertVC.zjid = model.zjid;
    
    
     expertVC.isMineView = YES;
    

    [self.navigationController pushViewController:expertVC animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
#pragma mark - 加载和刷新
//- (void)loadMoreData
//{
//  MineExpertModel *lastModel = [self.mineFocusExpertDataSource lastObject];
//    [self requestInfoWithLastId:lastModel.zjid];
//}

- (void)pullToRefresh
{
    [self requestInfoWithLastId:@"0"];
}
- (void)NetWorkingfaiure{
    NetfailureView *view = [[NetfailureView alloc] initWithFrame:CGRectMake(0,0 , kScreenSizeWidth, kScreenSizeHeight-(kStatusBarHeight+kNavigationBarHeight+47))];
    
    [self.view addSubview:view];
    
}


@end
