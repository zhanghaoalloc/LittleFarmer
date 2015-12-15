//
//  MyQuestionViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/21.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineReponseTableViewController.h"
#import "QuestionInfo.h"
#import "QuestionCell.h"
#import "QuestionCellSource.h"
#import "QuestionDetailViewController.h"

@interface MineReponseTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) UITableView *questionTab;


@end

@implementation MineReponseTableViewController

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
    if (!self.dataSourceArr.count)
    {
        [self.view showLoadingWihtText:@"加载中"];
    }
    NSDictionary *dic = @{@"userid":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userId]],@"id":lastId,@"pagesize":kPageSize};
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=tw&m=gethdtw4userid" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    NSMutableArray *curQuestions = [QuestionInfo arrayOfModelsFromDictionaries:[(NSDictionary *)responseObject objectForKey:@"list"]];
    
    if (!self.dataSourceArr)
    {
        self.dataSourceArr = [NSMutableArray arrayWithCapacity:10];
    }
    if (curQuestions.count)
    {
        if (!lastId.intValue)
        {
            [self.dataSourceArr removeAllObjects];
        }
        for (QuestionInfo *info in curQuestions)
        {
            QuestionCellSource *item = [[QuestionCellSource alloc] initWithQuestionInfo:info];
            [self.dataSourceArr addObject:item];
        }
    }
    [super reloadData];
    [self noMoreData:curQuestions.count < kPageSize.intValue];
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
    QuestionCellSource *lastSource = [self.dataSourceArr lastObject];
    [self requestDataWithLastId:lastSource.qInfo.qid];
}

- (void)pullToRefresh
{
    [self requestDataWithLastId:@"0"];
    
}


#pragma mark - tableviewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCellSource *curSource = [self.dataSourceArr objectAtIndex:indexPath.row];
    return curSource.cellTotalHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    QuestionCellSource *tmpSou = [self.dataSourceArr objectAtIndex:row];
    NSString *wtid = tmpSou.qInfo.qid;
    QuestionDetailViewController *quVC = [[QuestionDetailViewController alloc] initWithWtid:wtid];
    [self.navigationController pushViewController:quVC animated:YES];
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetfy = @"myresponseCell";
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:indetfy];
    if (!cell) {
        cell = [[QuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetfy];
    }
    
    [cell refreshWithQuestionCellSource:(QuestionCellSource *)self.dataSourceArr[indexPath.row]];
    
    return cell;
}

#pragma mark - 刷新和加载



@end
