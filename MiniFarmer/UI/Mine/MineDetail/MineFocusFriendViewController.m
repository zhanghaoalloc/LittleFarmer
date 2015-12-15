//
//  MIneExpertViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineFocusFriendViewController.h"
#import "MineFocusFriendCell.h"

@interface MineFocusFriendViewController ()

@property (nonatomic, strong) NSMutableArray *mineFocusFriendDataSource;

@end

@implementation MineFocusFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.view addSubview:self.tableView];
    
}


- (void)reloadData
{
    if (!self.mineFocusFriendDataSource.count)
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
                                             subUrl:@"?c=user&m=get_myfriend_list"
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
    MineFocusFriendModel *model = [[MineFocusFriendModel alloc] initWithDictionary:responseObject error:nil];
    if (!self.mineFocusFriendDataSource)
    {
        self.mineFocusFriendDataSource = [NSMutableArray array];
    }
    if (!lastId && model.list.count)
    {
        [self.mineFocusFriendDataSource removeAllObjects];
    }
    [self.mineFocusFriendDataSource addObjectsFromArray:model.list];
    [self noMoreData:model.list.count < kPageSize.intValue];
    [super reloadData];
    if (!self.mineFocusFriendDataSource.count)
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
    return self.mineFocusFriendDataSource.count;
}

- (MineFocusFriendCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"reuseMineFocusFriendCell";
    MineFocusFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[MineFocusFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    MineFocusFriendList *list = [self.mineFocusFriendDataSource objectAtIndex:indexPath.row];
    [cell refreshDataWithModel:list];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MineFocusFriendCell cellHeightWihtModel:nil];
}

#pragma mark - 加载和刷新

- (void)loadMoreData
{
    MineFocusFriendList *lastModel = [self.mineFocusFriendDataSource lastObject];
    [self requestInfoWithLastId:lastModel.listId];
}

- (void)pullToRefresh
{
    [self requestInfoWithLastId:@"0"];
}


@end
