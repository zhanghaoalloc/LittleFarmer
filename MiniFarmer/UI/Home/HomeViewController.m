//
//  HomeViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "HomeViewController.h"
#import "QuestionInfo.h"
#import "SimpleImageTitleButton.h"
#import "QuestionCell.h"
#import "MJRefresh.h"
#import "HomeMenuButton.h"
#import "QuestionDetailViewController.h"
#import "AskSpecialistViewController.h"
#import "SeachView.h"
#import "StudyViewController.h"
#import "DiseaDetailViewController.h"

#define kPageSize   @"10"   //一次请求数据数

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_sourceArr;
    NSUInteger      _totalQuestionCount;
    UIView          *_headView;
    SeachView        *_seachView;
}

@property (nonatomic , strong) UITableView *homeTableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.navigationController.navigationBar.hidden = YES;
    [self commonInit];
    [self addSubviews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self requestHomeDataWithId:@"0"];
    //通知告诉视图重新显示了
    [[NSNotificationCenter defaultCenter] postNotificationName:@"homeViewAppear" object:nil];
}


#pragma mark- private
- (void)commonInit
{
    _sourceArr = [NSMutableArray arrayWithCapacity:1];
    
}

- (void)addSubviews
{
    [self headViewInit];
    _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth, kScreenSizeHeight-kStatusBarHeight) style:UITableViewStylePlain];
    _homeTableView.dataSource = self;
    _homeTableView.delegate = self;
    _homeTableView.tableHeaderView = _headView;
    [self.view addSubview:_homeTableView];
    
    //搜索栏
    _seachView = [[NSBundle mainBundle]loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
  //  _seachView.backgroundColor = [UIColor redColor];
    _seachView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _seachView.frame = CGRectMake(0,kStatusBarHeight,kScreenSizeWidth , kNavigationBarHeight);
    _seachView.imageNmae = @"home_btn_message_nm";
    _seachView.isSearch = NO;
    _seachView.index = 1;
    [self.view addSubview:_seachView];
    
    MJRefreshNormalHeader *mjHeader= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLOG(@"home refresh!");
        [self requestHomeDataWithId:@"0"];
    }];
    _homeTableView.header = mjHeader;
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    //[mjHeader setTitle:@"" forState:MJRefreshStateIdle];
    
    
    
    _homeTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (_sourceArr.count == 0) {
            return ;
        }
        DLOG(@"home load more!");
        
        QuestionCellSource *lastSource = [_sourceArr lastObject];
        [self requestHomeDataWithId:lastSource.qInfo.qid];
//        [_homeTableView.footer endRefreshing];
    }];
}

- (void)headViewInit
{
    
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, CGRectGetWidth(self.view.bounds),255)];
    //_headView.backgroundColor = [UIColor yellowColor];
    CGFloat bannerHeight = 155;
    UIImageView *hImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_headView.bounds), bannerHeight)];
    [_headView addSubview:hImage];
    hImage.image = [UIImage imageNamed:@"home_banner.jpg"];
    //菜单选项
    CGFloat funHeight = 86;
    CGFloat sideSpadding = 20;
    CGFloat menuSpadding = (CGRectGetWidth(_headView.bounds)- sideSpadding*2 - kMenuBtnImgWidth*4)/3;
    UIView *funView = [[UIView alloc] initWithFrame:CGRectMake(0, bannerHeight+14, CGRectGetWidth(_headView.bounds), funHeight)];
    [_headView addSubview:funView];
    
    HomeMenuButton *buyBtn = [self menuButtonWithTitle:@"买农药" normalImgName:@"home_btn_buy_nm"];
    [funView addSubview:buyBtn];
    //buyBtn.frame = CGRectMake(sideSpadding, 0, kMenuBtnImgWidth, funHeight);
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(funView);
        make.left.equalTo(funView).offset(sideSpadding);
        make.size.mas_equalTo(CGSizeMake(kMenuBtnImgWidth,funHeight));
    }];
    
    HomeMenuButton *studyBtn = [self menuButtonWithTitle:@"学技术" normalImgName:@"home_btn_study_nm"];
    [funView addSubview:studyBtn];
    [studyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyBtn);
        make.left.equalTo(buyBtn.mas_right).offset(menuSpadding);
        make.size.mas_equalTo(buyBtn);
    }];
    [studyBtn addTarget:self action:@selector(studyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    HomeMenuButton *askBtn = [self menuButtonWithTitle:@"问专家" normalImgName:@"home_btn_ask_nm"];
    [askBtn addTarget:self action:@selector(tapAskBtn:) forControlEvents:UIControlEventTouchUpInside];
    [funView addSubview:askBtn];
    [askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyBtn);
        make.left.equalTo(studyBtn.mas_right).offset(menuSpadding);
        make.size.mas_equalTo(buyBtn);
    }];
    
    HomeMenuButton *methodBtn = [self menuButtonWithTitle:@"找配方" normalImgName:@"home_btn_method_nm"];
    [funView addSubview:methodBtn];
    [methodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyBtn);
        make.left.equalTo(askBtn.mas_right).offset(menuSpadding);
        make.size.mas_equalTo(buyBtn);
    }];
}

//创建一个菜单按钮
- (HomeMenuButton *)menuButtonWithTitle:(NSString *)title normalImgName:(NSString *)nmName
{
    HomeMenuButton *tmpBtn = [HomeMenuButton buttonWithType:UIButtonTypeCustom];
    //tmpBtn.backgroundColor = [UIColor redColor];
    [tmpBtn setTitle:title forState:UIControlStateNormal];
    [tmpBtn setTitleColor:RGBCOLOR(61, 61, 61) forState:UIControlStateNormal];
    tmpBtn.titleLabel.font = kTextFont14;
    tmpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tmpBtn setImage:[UIImage imageNamed:nmName] forState:UIControlStateNormal];
    
    return tmpBtn;
}

- (void)requestHomeDataWithId:(NSString *)lastId
{
    NSDictionary *dicPar =@{
//                            @"c":@"tw",
//                            @"m":@"gettwlist",
                            @"id":lastId,
                            @"pagesize":kPageSize,
                            };
    __weak HomeViewController *wself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet
                                             subUrl:@"?c=tw&m=gettwlist"
                                         parameters: dicPar
                                     prepareExecute:nil
                                            success:^(NSURLSessionDataTask *task, id responseObject)
    {
        [_homeTableView.header endRefreshing];
        [_homeTableView.footer endRefreshing];
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
                //加载数据成功
                NSMutableArray *curQuestions = [QuestionInfo arrayOfModelsFromDictionaries:[dicResult objectForKey:@"list"]];
                //如果是刷新数据
                if ([lastId isEqualToString:@"0"]) {
                    [_sourceArr removeAllObjects];
                }
                
                for (int i =0; i<curQuestions.count; i++) {
                    QuestionInfo *info = [curQuestions objectAtIndex:i];
                    QuestionCellSource *item = [[QuestionCellSource alloc] initWithQuestionInfo:info];
                    [_sourceArr addObject:item];
                }
                
                [wself.homeTableView reloadData];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [_homeTableView.header endRefreshing];
        [_homeTableView.footer endRefreshing];
    }];
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCellSource *curSource = [_sourceArr objectAtIndex:indexPath.row];
    return curSource.cellTotalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    QuestionCellSource *tmpSou = [_sourceArr objectAtIndex:row];
    NSString *wtid = tmpSou.qInfo.qid;
    QuestionDetailViewController *quVC = [[QuestionDetailViewController alloc] initWithWtid:wtid];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:quVC animated:YES];
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetfy = @"homecell";
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:indetfy];
    if (!cell) {
        cell = [[QuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetfy];
    }
    
    [cell refreshWithQuestionCellSource:(QuestionCellSource *)_sourceArr[indexPath.row]];
    
    return cell;
}
#pragma mark ----菜单按钮绑定的事件
- (void)studyAction:(UIButton *)button{
    
    /*
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    messageVC.view.backgroundColor = [UIColor whiteColor];
    
    self.ViewController.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self.ViewController.navigationController pushViewController:messageVC animated:YES];
     */

    StudyViewController *studyVC = [[StudyViewController alloc] init];
    self.tabBarController.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:studyVC animated:YES];
}



#pragma mark - clickevent
- (void)tapAskBtn:(UIButton *)btn
{
    AskSpecialistViewController *askSVC = [[AskSpecialistViewController alloc] init];
    [self.navigationController pushViewController:askSVC animated:YES];

}

@end
