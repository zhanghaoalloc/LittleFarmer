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

@interface MIneExpertViewController ()

@property (nonatomic, strong) NSMutableArray *mineFocusExpertDataSource;

@end

@implementation MIneExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.tableView];
    
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
    NSDictionary *dic = @{@"userid":[APPHelper safeString:userId]};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet
                                             subUrl:@"?c=user&m=get_mygzzj_list"
                                         parameters:dic
                                     prepareExecute:nil
                                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                                //解析数据
                                                [self.view dismissLoading];
                                                [self cancelCurrentLoadAnimation];
                                                [self handleSucessWithResult:lastId lastId:responseObject];
                                                
                                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                [self.view dismissLoading];
                                                [self cancelCurrentLoadAnimation];

                                                [self handleFailure];
                                            }];
}


- (void)handleSucessWithResult:(id)responseObject lastId:(NSString *)lastId
{
    MineExpertModel *model = [[MineExpertModel alloc] initWithDictionary:responseObject error:nil];
    if (!self.mineFocusExpertDataSource)
    {
        self.mineFocusExpertDataSource = [NSMutableArray array];
    }
    if (!lastId && model.list.count)
    {
        [self.mineFocusExpertDataSource removeAllObjects];
    }
    [self.mineFocusExpertDataSource addObjectsFromArray:model.list];
    [self noMoreData:model.list.count < kPageSize.intValue];
    [super reloadData];
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

- (MineFoucsExpertCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak MIneExpertViewController *weakSelf = self;
    static NSString *identifier = @"reuseCell";
    MineFoucsExpertCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[MineFoucsExpertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.tapAskMineExpert = ^(){
            AskViewController *askVC = [[AskViewController alloc] init];
            [weakSelf.navigationController pushViewController:askVC animated:YES];
        };
    }
    MineExpertList *list = [self.mineFocusExpertDataSource objectAtIndex:indexPath.row];
    [cell refreshDataWithModel:list];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MineFoucsExpertCell cellHeightWihtModel:nil];
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
