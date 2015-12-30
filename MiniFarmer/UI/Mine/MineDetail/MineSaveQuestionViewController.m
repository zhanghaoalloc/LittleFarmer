//
//  MIneExpertViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSaveQuestionViewController.h"
#import "MyAnswerCell.h"
#import "UserInfo.h"
#import "QuestionDetailViewController.h"
#import "MJRefresh.h"



@interface MineSaveQuestionViewController ()

@property (nonatomic, strong) NSMutableArray *mineQuestionDataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineSaveQuestionViewController
{

    NSString *_identify;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.mineQuestionDataSource = [NSMutableArray array];
    
    [self _requesData];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}
- (void)_requesData{
    BOOL status =[[SHHttpClient defaultClient] isConnectionAvailable];
    if (status == NO) {
        [self NetWorkingfaiure];
        return;
    }

    [self.view showLoadingWihtText:@"加载中"];
    NSString *userid = [UserInfo shareUserInfo].userId;
    
    NSDictionary * dic = @{
                           @"userid":userid,
                           @"pagesize":@"3",
                           @"id":@"0"
                           };
    __weak MineSaveQuestionViewController *wself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=tw&m=get_wtcollection" parameters:dic     prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *code = [responseObject objectForKey:@"code"];
        [wself.view dismissLoading];
        if ([code integerValue]== 1) {
            
            NSArray *array = [responseObject objectForKey:@"list"];
           
            NSMutableArray *curQuestions = [QuestionInfo arrayOfModelsFromDictionaries:array];
            for (int i =0; i<curQuestions.count; i++) {
                QuestionInfo *info = [curQuestions objectAtIndex:i];
                QuestionCellSource *item = [[QuestionCellSource alloc] initWithQuestionInfo:info];
                [_mineQuestionDataSource addObject:item];
            }
            [wself _createSubView];
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
    }];

}
- (void)_createSubView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth,kScreenSizeHeight-kNavigationBarHeight-kStatusBarHeight-47)  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //下拉刷新
    /*
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSString *lastid = @"0";
        NSDictionary *dic1 = @{
                               @"id":lastid,
                               @"pagesize":@"10"
                               };
        
        // [self requestQuDataWithUserId:userid wtid:_curWtid];
        [self requestData:@"?c=wwzj&m=getzjlist" withDictionary:dic1
               withMethod:SHHttpRequestGet];
    }];
     */

    
    
    
   
   [ self.view addSubview:_tableView];
   
}
#pragma mark --- UITableView协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.mineQuestionDataSource.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identity = @"myCell";
    MyAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[MyAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    [cell refreshWithQuestionCellSource:(QuestionCellSource *)self.mineQuestionDataSource[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionCellSource *curSource = [_mineQuestionDataSource objectAtIndex:indexPath.row];
    return curSource.cellTotalHeight-20-10;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionCellSource *curSource = [_mineQuestionDataSource objectAtIndex:indexPath.row];

    QuestionDetailViewController *questiondetailViewVC = [[QuestionDetailViewController alloc] initWithWtid:curSource.qInfo.qid];
    
    [self.navigationController pushViewController:questiondetailViewVC animated:YES];

}
- (void)NetWorkingfaiure{
    NetfailureView *view = [[NetfailureView alloc] initWithFrame:CGRectMake(0,0 , kScreenSizeWidth, kScreenSizeHeight-(kStatusBarHeight+kNavigationBarHeight+47))];
    
    [self.view addSubview:view];
    
}






@end
