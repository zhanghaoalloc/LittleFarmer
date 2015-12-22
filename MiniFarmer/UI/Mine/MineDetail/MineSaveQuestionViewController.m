//
//  MIneExpertViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSaveQuestionViewController.h"
#import "MineSaveQuestionCell.h"

@interface MineSaveQuestionViewController ()

@property (nonatomic, strong) NSMutableArray *mineQuestionDataSource;

@end

@implementation MineSaveQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.view addSubview:self.tableView];
    
}


- (void)reloadData
{
    if (!self.mineQuestionDataSource.count)
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
                          @"userid":userId
                          };
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet
    subUrl:@"?c=tw&m=get_wtcollection" parameters:dic prepareExecute:nil
    success:^(NSURLSessionDataTask *task, id responseObject)
    {
        
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
    MineSaveQuestionModel *model = [[MineSaveQuestionModel alloc] initWithDictionary:responseObject error:nil];
    if (!self.mineQuestionDataSource)
    {
        self.mineQuestionDataSource = [NSMutableArray array];
    }
    if (!lastId && model.list.count)
    {
        [self.mineQuestionDataSource removeAllObjects];
    }
    [self.mineQuestionDataSource addObjectsFromArray:model.list];
    [self noMoreData:model.list.count < kPageSize.intValue];
    [super reloadData];
    if (!self.mineQuestionDataSource.count)
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
    return self.mineQuestionDataSource.count;
}

- (MineSaveQuestionCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MineSaveQuestionCell";
    MineSaveQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[MineSaveQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    MineSaveQuestionModelList *list = [self.mineQuestionDataSource objectAtIndex:indexPath.row];
    [cell refreshDataWithModel:list];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MineSaveQuestionCell cellHeightWihtModel:nil];
}

#pragma mark - 加载和刷新

- (void)loadMoreData
{
    MineSaveQuestionModelList *lastModel = [self.mineQuestionDataSource lastObject];
    [self requestInfoWithLastId:lastModel.listId];
}

- (void)pullToRefresh
{
    [self requestInfoWithLastId:@"0"];
}


@end
