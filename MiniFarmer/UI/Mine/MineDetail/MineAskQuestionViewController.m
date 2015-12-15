//
//  MineResponseTableController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/19.
//  Copyright © 2015年 enbs. All rights reserved.
//




#import "MineAskQuestionViewController.h"
#import "MyAskQuestionModel.h"
#import "MineAskQuestionCell.h"
#import "MineAskQuestionImagesCell.h"

@interface MineAskQuestionViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceArr;


@end

@implementation MineAskQuestionViewController

- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#eeeeee"]];
    [self setTableBackGroundColor:[UIColor colorWithHexString:@"#eeeeee"]];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)reloadData
{
    if (!_dataSourceArr)
    {
        [self requestDataWithLastId:@"0"];
    }

}

#pragma mark - other

- (void)requestDataWithLastId:(NSString *)lastId
{
    //添加loading
    NSLog(@"---------- requestCount");
    if (!self.dataSourceArr.count)
    {
        [self.view showLoadingWihtText:@"加载中"];
    }

    NSDictionary *dic = @{@"userid":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userId]],@"id":lastId,@"pagesize":kPageSize,@"mobile":[[MiniAppEngine shareMiniAppEngine] userLoginNumber]};
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=tw&m=gettw4userid" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.view dismissLoading];
        [self cancelCurrentLoadAnimation];
        [self handleSuccess:responseObject lastId:lastId];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view dismissLoading];
        [self cancelCurrentLoadAnimation];
        [self handleFailure];
    }];
}

- (void)handleSuccess:(id)responseObject lastId:(NSString *)lastId
{
    //如果是0代表刷新 那么如果请求到了数据就要清楚现在的数据
    MyAskQuestionModel *model = [[MyAskQuestionModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
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
    
//    for (int i = 0; i < 10; i++) {
//        MyAskQuestionList *list = [[MyAskQuestionList alloc] init];
//        [self.dataSourceArr addObject:list];
//    }
    [self noMoreData:model.list.count < kPageSize.intValue];
    if (!self.dataSourceArr.count)
    {
        //这里显示无结果页
        [self.view showWeakPromptViewWithMessage:@"没有内容哦"];
    }
    [super reloadData];
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

- (MyAskQuestionList *)lastMyReponseModel
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
    
    MyAskQuestionList *model = [_dataSourceArr objectAtIndex:indexPath.row];
    if (model.images.count)
    {
        return [MineAskQuestionImagesCell cellHeightWihtModel:model];
    }
    return [MineAskQuestionCell cellHeightWihtModel:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAskQuestionList *model = [_dataSourceArr objectAtIndex:indexPath.row];
    MineBaseTableViewCell *cell;
    if (model.images.count)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MineAskQuestionImagesCell"];
        if (!cell)
        {
          cell = [[MineAskQuestionImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineAskQuestionImagesCell"];
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MineAskQuestionCell"];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineAskQuestionCell" owner:self options:nil] lastObject];
        }
    }
    [cell refreshDataWithModel:model];
    return cell;
}


@end
