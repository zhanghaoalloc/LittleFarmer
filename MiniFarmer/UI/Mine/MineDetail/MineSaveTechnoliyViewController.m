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

@interface MineSaveTechnoliyViewController ()

@property (nonatomic, strong) NSMutableArray *mineAskDataSource;

@end

@implementation MineSaveTechnoliyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.view addSubview:self.tableView];
    
}


- (void)reloadData
{
    if (!self.mineAskDataSource.count)
    {
        [self requestInfoWithLastId:@"0"];
    }
}

- (void)requestInfoWithLastId:(NSString *)lastId
{
    //添加loading
    [self.view showLoadingWihtText:@"加载中..."];
    NSString *userId = [[MiniAppEngine shareMiniAppEngine] userId];
    NSDictionary *dic = @{
                          @"userid":[APPHelper safeString:userId]
                          
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
        self.mineAskDataSource = [NSMutableArray array];
    }
    if (!lastId && model.list.count)
    {
        [self.mineAskDataSource removeAllObjects];
    }
    [self.mineAskDataSource addObjectsFromArray:model.list];
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

#pragma mark - 加载和刷新

- (void)loadMoreData
{
    MineSaveTechnologyList *lastModel = [self.mineAskDataSource lastObject];
    [self requestInfoWithLastId:lastModel.listId];
}

- (void)pullToRefresh
{
    [self requestInfoWithLastId:@"0"];
}


@end
