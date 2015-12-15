//
//  MineRecipeViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineRecipeViewController.h"
#import "MyRecipeModel.h"
#import "MyRecipeCell.h"

@interface MineRecipeViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation MineRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDataWithLastId:@"0"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestDataWithLastId:(NSString *)lastId
{
    NSDictionary *dic = @{@"userid":[[MiniAppEngine shareMiniAppEngine] userId],@"id":lastId,@"pageSize":@"10"};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"?c=wzpf&m=get_userpf" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)handleSuccess:(id)responseObject lastId:(NSString *)lastId
{
    //如果是0代表刷新 那么如果请求到了数据就要清楚现在的数据
    MyRecipeModel *model = [[MyRecipeModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
    if (!self.dataSourceArr)
    {
        self.dataSourceArr = [NSMutableArray arrayWithArray:model.list];
    }
    if (model.list.count)
    {
        if (!lastId.intValue)
        {
            [self.dataSourceArr removeAllObjects];
        }
        [self.dataSourceArr addObjectsFromArray:model.list];
    }
    [self noMoreData:model.list.count < kPageSize.intValue];
    [super reloadData];
    if (!self.dataSourceArr.count)
    {
        //这里显示无结果页
        [self.view showWeakPromptViewWithMessage:@"没有内容哦"];
    }
}

- (void)handleFailure
{
    [self.view showWeakPromptViewWithMessage:@"加载失败"];
}

- (void)loadMoreData
{
    [self requestDataWithLastId:[self lastMyReponseModel].listId];
}

- (void)pullToRefresh
{
    [self requestDataWithLastId:@"0"];
    
}

- (MyRecipeList *)lastMyReponseModel
{
    return [_dataSourceArr lastObject];
}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyRecipeList *model = [_dataSourceArr objectAtIndex:indexPath.row];
    if (model.images.count)
    {
        return [MyRecipeCell cellHeightWihtModel:model];
    }
    return [MyRecipeCell cellHeightWihtModel:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyRecipeList *model = [_dataSourceArr objectAtIndex:indexPath.row];
    MyRecipeCell *cell;
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyRecipeCell"];
        if (!cell)
        {
            cell = [[MyRecipeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyRecipeCell"];
        }
   
    [cell refreshDataWithModel:model];
    return cell;
}
@end
