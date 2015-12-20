//
//  QuestionDetailViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "QuCommonView.h"
#import "BaseViewController+Navigation.h"
#import "QuestionAnsModel.h"
#import "QuAnswerHeaderView.h"
#import "QuAnswerReplyCell.h"
#import "UIView+FrameCategory.h"
#import "MyanswerViewController.h"
#import "UMSocial.h"
#import "MJRefresh.h"
#import "UserInfo.h"
#import "ReplyViewController.h"
#import "LoginViewController.h"
#import "LoginModel.h"
#import "AppDelegate.h"




@interface QuestionDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSString *curWtid;
@property (nonatomic, strong)QuCommonView *commonView;
@property (nonatomic, strong)QuestionInfo *qInfo;
@property (nonatomic, strong)NSMutableArray *qAnsArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *answerbutton;
@property (nonatomic, strong)UIView *noanswerView;

@property (nonatomic, strong)UIButton *sharebutton;
@property (nonatomic, strong)UIButton *colloctionbutton;


@property(nonatomic ,assign)BOOL isSelf;
@end

@implementation QuestionDetailViewController
- (instancetype)initWithWtid:(NSString *)wtid
{
    self = [super init];
    if (self) {
        _curWtid = wtid;
        _qAnsArr = [NSMutableArray arrayWithCapacity:1];
    }
    
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // D any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setNavigationBarIsHidden:NO];
    [self setNaVIgationBackAction:self action:@selector(backBtnPressed)];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self initNavigationbgView:[UIColor colorWithHexString:@"#ffffff"]];

    
    //设置导航栏和状态栏的颜色
    
    //设置导航栏下方分割线
    //[self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#a3a3a3"] heigth:0.5];
    //配置分享，和收藏按钮
    [self commonInit];
    
    [self addSubviews];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];
    
    
    NSString *userId;
    if ([[MiniAppEngine shareMiniAppEngine] isLogin]) {
        userId = [[MiniAppEngine shareMiniAppEngine] userId];
    }
    else{
        userId = @"0";
    }
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#a3a3a3"] heigth:0.5];
    [self requestQuDataWithUserId:userId wtid:_curWtid];
    }


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self setNavigationBarIsHidden:YES];
}

#pragma mark- private
- (void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

//初始化导航栏的上的按钮
- (void)commonInit
{   if(_sharebutton == nil){
    _sharebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sharebutton.frame = CGRectMake(kScreenSizeWidth-44, kStatusBarHeight, kNavigationBarHeight, kNavigationBarHeight);
    _sharebutton.backgroundColor = [UIColor clearColor];
    [_sharebutton setImage:[UIImage imageNamed:@"home_question_share_btn"] forState:UIControlStateNormal];
    [_sharebutton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sharebutton];
}

    
    if (_colloctionbutton == nil) {
        
    _colloctionbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _colloctionbutton.frame = CGRectMake(kScreenSizeWidth-88, kStatusBarHeight, kNavigationBarHeight, kNavigationBarHeight);
    [_colloctionbutton setImage:[UIImage imageNamed:@"home_question_collection_btn_nm"] forState:UIControlStateNormal];
    [_colloctionbutton setImage:[UIImage imageNamed:@"home_question_collection_btn_select"] forState:UIControlStateSelected];

    [_colloctionbutton addTarget:self action:@selector(colloectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_colloctionbutton];
    }
   // colloctionbutton.backgroundColor = [UIColor greenColor];
    
    [self initAnswerView];
    
    

}

- (void)addSubviews
{   //问题视图
    self.commonView = [[QuCommonView alloc] init];
    
    //回复列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加下拉刷新
    NSString *userid = [UserInfo shareUserInfo].userId;
    
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestQuDataWithUserId:userid wtid:_curWtid];
    }];
    _tableView.header = mjHeader;

    
}
// 初始化我解答的按钮
- (void)initAnswerView{
    UIView *answerView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenSizeHeight-60,kScreenSizeWidth, 60)];
    answerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:answerView];
    
    //我解答视图上方的分割线
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 0.5)];
    separatorLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [answerView addSubview:separatorLine];
    
    //我解答的按钮
    _answerbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _answerbutton.frame = CGRectMake(12,8,kScreenSizeWidth-24,44 );
    
    [_answerbutton setBackgroundImage:[UIImage imageNamed:@"home_question_list_answer_btn"] forState:UIControlStateNormal];
    [_answerbutton setBackgroundImage:[UIImage imageNamed:@"home_question_list_answer_btn"] forState:UIControlStateHighlighted];
    [_answerbutton setTitle:@"我解答" forState:UIControlStateNormal];
    _answerbutton.titleLabel.font = kTextFont18;
    [_answerbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_answerbutton addTarget:self action:@selector(answerButton:) forControlEvents:UIControlEventTouchUpInside];
    [answerView addSubview:_answerbutton];
}
//我解答的按钮
- (void)answerButton:(UIButton *)button{
    
    //判断是否登录
    NSString *userid = [UserInfo shareUserInfo].userId
    ;
    if (userid == nil) {
        button.selected = NO;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self presentViewController:loginVC animated:YES completion:nil];
        loginVC.loginBackBlock = ^{
        };
    }else{
        
        MyanswerViewController *myanswerVC = [[MyanswerViewController alloc] init];
        myanswerVC.info = self.qInfo;
        myanswerVC.wtid = _curWtid;
        
        [self.navigationController pushViewController:myanswerVC animated:YES ];

    
    }

}

- (void)updateViewWhenGetData
{
    //title
    NSString *title = [NSString stringWithFormat:@"%@的问题",_qInfo.xm];
    [self setBarTitle:title];
    //如果是自己提的问题
    _colloctionbutton.hidden = _isSelf;
    
    //问题及回答列表
    CGFloat curY = kStatusBarHeight+kNavigationBarHeight+1;
    _tableView.frame = CGRectMake(0, curY, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-curY-60);
    
    //问题内容
    [_commonView refreshWithQuestionInfo:_qInfo];
    CGFloat needHeight = _commonView.totalViewHeight;
    _commonView.frame = CGRectMake(0, 0, _tableView.bounds.size.width, needHeight);
    
    _tableView.tableHeaderView = _commonView;
    
    //如果问题的回答列表为空
    [self initNoanswerView];
    
    if (self.qAnsArr.count == 0) {
        _noanswerView.hidden = NO;
        
       // _tableView.hidden = YES;
    }
    

    //回答列表
//    CGFloat curY = kStatusBarHeight+kNavigationBarHeight + needHeight;
//    _tableView.frame = CGRectMake(0, curY, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-curY);
    [_tableView reloadData];
}
- (void)initNoanswerView{
    
    if (_commonView) {
        _noanswerView =[[UIView alloc] initWithFrame:CGRectMake(0, _commonView.bottom+kNavigationBarHeight+kStatusBarHeight, kScreenSizeWidth, kScreenSizeHeight-_commonView.bottom-60-kStatusBarHeight-kNavigationBarHeight)];

        _noanswerView.hidden = YES;
        
        
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 0.5)];
        lineView.backgroundColor  = [UIColor colorWithHexString:@"#dddddd"];
        [_noanswerView addSubview:lineView];
        
        //图片
        UIImageView *noAnswer = [UIImageView new];
        [noAnswer setImage:[UIImage imageNamed:@"home_question_no_answer"]];
        noAnswer.frame = CGRectMake((kScreenSizeWidth-49)/2,56,49, 49);
        noAnswer.contentMode = UIViewContentModeScaleAspectFit;
        [_noanswerView addSubview:noAnswer];
        //文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, noAnswer.bottom, kScreenSizeWidth-20,20 )];
        label.font = kTextFont14;
       // label.textColor = [UIColor colorAndAlphaWithHexString:@"#ffffff"];
        [label setTextColor:[UIColor colorWithHexString:@"#a3a3a3"]];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂时还没有人回答";
        [_noanswerView addSubview:label];

        [self.view addSubview:_noanswerView];
    }

}


#pragma mark- 网络请求
- (void)requestQuDataWithUserId:(NSString *)uid wtid:(NSString *)wtid
{
    NSDictionary *dicPar =@{
//                          @"c":@"tw",
//                          @"m":@"getwthflist",
                            @"userid":[NSNumber numberWithInt:[uid intValue]],
                            @"wtid":[NSNumber numberWithInt:[wtid intValue]],
                            };
    __weak QuestionDetailViewController *wself = self;
    
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=tw&m=getwthflist"
                                         parameters:dicPar
                                     prepareExecute:nil
                                            success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [_tableView.header endRefreshing];
        if (!responseObject) {
            DLOG(@"responseObject is nil");
            return ;
        }
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResult = responseObject;
            BOOL code = [[dicResult objectForKey:@"code"] boolValue];
            NSString *msg = [dicResult objectForKey:@"msg"];
            
            DLOG(@"code = %d,msg = %@",code,msg);
            if (!code) {
                //显示加载错误提示
                return;
            }
            else{
                //问题详情
                NSDictionary *dicQueInfo = [dicResult objectForKey:@"wt"];
                
                self.qInfo = [[QuestionInfo alloc] initWithDictionary:dicQueInfo error:nil];
                
                //判断是否是自己的问题
                if (_qInfo.userid == uid) {//是自己提的问题
                    _isSelf = YES;
                }else{
                
                    _isSelf = NO;
                }
                //回答列表
                self.qAnsArr = [QuestionAnsModel arrayOfModelsFromDictionaries:[dicResult objectForKey:@"list"]];
               // NSDictionary *dic = [dicResult objectForKey:@"list"];
              //  BOOL iscoll = [[dic objectForKey:@"iscoll"] boolValue];
                
                //刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    
               _colloctionbutton.selected = [_qInfo.iscoll boolValue];
                    [wself updateViewWhenGetData];
                    [wself.tableView reloadData];
                });
                return;
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [_tableView.header endRefreshing];
    }];
}

#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _qAnsArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:section];
    return ansItem.relist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:indexPath.section];
    
    ReplyModel *repItem = [ansItem.relist objectAtIndex:indexPath.row];
    
    static NSString *identifier = @"relistCell";
    QuAnswerReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QuAnswerReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    [cell refreshWithReplyModel:repItem];
    
    
    return cell;
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:section];
    CGFloat height = [QuAnswerHeaderView headerHeightWithAnsModel:ansItem];
    return height;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:indexPath.section];
    ReplyModel *repItem = [ansItem.relist objectAtIndex:indexPath.row];
    CGFloat height = [QuAnswerReplyCell cellTotalHightWithReplyModel:repItem];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    QuestionAnsModel *ansItem = [_qAnsArr objectAtIndex:section];
    
    static NSString *HeaderIdentifier = @"QuHeader";
    
    QuAnswerHeaderView *myHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    //消除单元格复用的影响当有附带图片有回复以及是专家的时候
    if (ansItem.fdzp!= nil||ansItem.relist.count!= 0||[ansItem.zjid intValue]!=0) {
        myHeader = nil;
    }
    
    if(!myHeader) {
        myHeader = [[QuAnswerHeaderView alloc] initWithReuseIdentifier:HeaderIdentifier];
    }
    [myHeader refreshWithAnsModel:ansItem];
     myHeader.isSelf = _isSelf;
    //只是判断了单个单元格是否被采纳
    myHeader.isAdopt = [ansItem.iscn boolValue];
    //判断这个问题是否被采纳
    myHeader.isQuesCn = _qInfo.iscn;
    
    return myHeader;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReplyViewController *replyVC = [[ReplyViewController alloc] init];
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:indexPath.section];
    ReplyModel *repItem = [ansItem.relist objectAtIndex:indexPath.row];
    
    
    replyVC.model =ansItem;
    replyVC.replymodel = repItem;
    
    
    replyVC.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:replyVC animated:YES];



}
#pragma mark----收藏和分享的按钮的点击事件
- (void)shareAction:(UIButton *)button{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5663c9dee0f55a74a2000b0e"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,]
                                       delegate:self];

}
- (void)colloectionAction:(UIButton *)button{
    //判断是否登录
    NSString *userid = [UserInfo shareUserInfo].userId
    ;
    if (userid == nil) {
        button.selected = NO;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self presentViewController:loginVC animated:YES completion:nil];
        loginVC.loginBackBlock = ^{
            
        };
    }else{
        if (button.selected == NO) {//收藏

            [self requestCollection:@"?c=tw&m=add_wt_collection" isCollection:YES action:button];
            
        }else{
            [self requestCollection:@"?c=tw&m=cancel_wt_collection" isCollection:NO action:button];
        }

    
    }

    
}

//收藏和取消问题
- (void)requestCollection:(NSString *)url isCollection:(BOOL)iscoll action:(UIButton *)button{
    NSString *userId;
    
    if ([[MiniAppEngine shareMiniAppEngine] isLogin]) {
        userId = [[MiniAppEngine shareMiniAppEngine] userId];
    }
    else{
        userId = @"0";
    }
    NSDictionary *dic = @{
                          @"userid":[NSNumber numberWithInt:[userId intValue]],
                          @"wtid":[NSNumber numberWithInt:[_curWtid intValue]]
                          };

    [[SHHttpClient defaultClient]requestWithMethod:SHHttpRequestGet subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *str = responseObject[@"msg"];
        if ([str isEqualToString:@"success"]) {
            
            if (iscoll == YES) {
                [self.view showWeakPromptViewWithMessage:@"收藏成功"];
            }else{
                [self.view showWeakPromptViewWithMessage:@"取消收藏"];
            
            }
            //刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                button.selected = !button.selected;
            });
        }else{
            
            if (iscoll == YES) {
                [self.view showWeakPromptViewWithMessage:@"收藏失败"];
            }else{
                [self.view showWeakPromptViewWithMessage:@"取消收藏失败"];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark--- 下拉刷新





@end
