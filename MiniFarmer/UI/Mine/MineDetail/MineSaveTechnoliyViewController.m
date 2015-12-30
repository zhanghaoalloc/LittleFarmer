//
//  MIneExpertViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSaveTechnoliyViewController.h"
#import "MineSaveAskCell.h"
#import "MineSaveTechnology.h"
#import "DiseaDetailViewController.h"
#import "MyQuestionCell.h"
#import "NetfailureView.h"

@interface MineSaveTechnoliyViewController ()

@property (nonatomic, strong) NSMutableArray *mineAskDataSource;

@end

@implementation MineSaveTechnoliyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)reloadData
{
    if (!self.mineAskDataSource.count)
    {
        [self requestInfoWithLastId:@"0"];
    }
}

- (void)requestInfoWithLastId:(NSString *)lastId
{   BOOL status =[[SHHttpClient defaultClient] isConnectionAvailable];
    if (status == NO) {
        [self NetWorkingfaiure];
        return;
    }
    //添加loading
    NSLog(@"---------- requestCount");
    if (!self.mineAskDataSource.count)
    {
        [self.view showLoadingWihtText:@"加载中"];
    }
    NSString *userId = [[MiniAppEngine shareMiniAppEngine] userId];
    NSDictionary *dic = @{
                          @"userid":[APPHelper safeString:userId],
                          @"id":lastId,
                          @"pagesize":@"10"
                          };
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet
    subUrl:@"?c=wxjs&m=get_wxjscollection"parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
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
    MineSaveTechnology *model = [[MineSaveTechnology alloc] initWithDictionary:responseObject error:nil];
    
    if (!self.mineAskDataSource)
    {
        self.mineAskDataSource = [NSMutableArray arrayWithArray:model.list];
    }
    if ( model.list.count)
    {
        if (!lastId) {
            [self.mineAskDataSource removeAllObjects];

        }
        [self.mineAskDataSource addObjectsFromArray:model.list];
    }
    
   
    
    [self noMoreData:model.list.count < kPageSize.intValue];
   
    [super reloadData];
    
    if (!self.mineAskDataSource.count)
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
    [self requestInfoWithLastId:[self lastMysaveTechnology].listId];


}
- (MineSaveTechnologyList *)lastMysaveTechnology{

    return [_mineAskDataSource lastObject];
}

#pragma mark----UITabelView协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 100;
    return self.mineAskDataSource.count;
}

- (MineSaveAskCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MineSaveAskCell";
    MineSaveAskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[MineSaveAskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    MineSaveTechnologyList *list = [self.mineAskDataSource objectAtIndex:indexPath.row];
    
    [cell refreshDataWithModel:list];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MineSaveAskCell cellHeightWihtModel:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineSaveTechnologyList *list = [self.mineAskDataSource objectAtIndex:indexPath.row];
    
    DiseaDetailViewController *detailVC = [[DiseaDetailViewController alloc] init];
    detailVC.bchid = list.listId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 加载和刷新

- (void)pullToRefresh
{
    [self requestInfoWithLastId:@"0"];
}

//无网络状态
- (void)NetWorkingfaiure{
    NetfailureView *view = [[NetfailureView alloc] initWithFrame:CGRectMake(0,0 , kScreenSizeWidth, kScreenSizeHeight-(kStatusBarHeight+kNavigationBarHeight+47))];
    
    [self.view addSubview:view];
    
}

@end
