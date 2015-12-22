//
//  AskSpecialistViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskSpecialistViewController.h"
#import "BaseViewController+Navigation.h"
#import "SeachView.h"
#import "UIViewAdditions.h"
#import "ListExpertView.h"
#import "ExpertListTableView.h"
#import "ExpertModel.h"
#import "MJRefresh.h"


@interface AskSpecialistViewController ()

@property (nonatomic,strong) SeachView *searchView;

@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIImageView *leftImage;

@property (nonatomic, strong)UIView *rigthView;
@property (nonatomic, strong)UILabel *rigthLabel;
@property (nonatomic, strong)UIImageView *rigthImage;

@property (nonatomic, strong)ListExpertView *leftList;
@property (nonatomic, strong)ListExpertView *rigthList;

@property(nonatomic,strong)NSArray *rigthdata;
@property(nonatomic,strong)NSArray *leftdata;

@property(nonatomic,strong)ExpertListTableView *expertTableView;

@property(nonatomic,strong)NSMutableArray *data;




@end

@implementation AskSpecialistViewController{

    NSString *_identify;

}
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.view.backgroundColor =[UIColor colorWithHexString:@"#ffffff"];
    [self setNavigationBarIsHidden:NO];
    
    _data = [NSMutableArray array];
    
   
    //初始化导航栏
    [self setNavigation];
    
    //获取列表的数据
    [self loadListData];
    //创建专家信息的tableView
    [self initexpertTableView];
    
    
    [self initsubviews];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    
    
}
- (void)setNavigation{
    //1.搜索栏
    _searchView  = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    _searchView.frame = CGRectMake(35,kStatusBarHeight , kScreenSizeWidth-35,kNavigationBarHeigth);
    _searchView.imageNmae = @"home_btn_message_nm";
    _searchView.isSearch = NO;
    _searchView.index = 4;
    
    [self.view addSubview:_searchView];
    
    //2.导航栏返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    //3.导航栏底部分割线
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#eeeeee"] heigth:0.5];
}
- (void)loadListData{
    self.rigthdata = @[@"距离",@"关注度",@"智能排序"];

    
    __weak AskSpecialistViewController *wself = self;
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=wwzj&m=get_zjlx_list"parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        wself.leftdata = [responseObject objectForKey:@"list"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //回到主线程刷新UI
           // [wself.leftList reloadData];
            [wself initlistTableView];

        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
    
}
//初始化UITableView
- (void)initexpertTableView{
    

    _expertTableView = [[ExpertListTableView alloc] initWithFrame:CGRectMake(0,kNavigationBarHeight+kStatusBarHeight+44, kScreenSizeWidth, kScreenSizeHeight-(kNavigationBarHeight+kStatusBarHeight+44)) style:UITableViewStylePlain];
   
    NSDictionary *dic = @{
                          @"id":@"0",
                          @"pagesize":@"10"
                          };
    
    [self requestData:@"?c=wwzj&m=getzjlist" withDictionary:dic withMethod:SHHttpRequestGet];
    //上拉刷新
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSDictionary *dic1 = @{
                              @"id":@"0",
                              @"pagesize":@"10"
                              };
       // [self requestQuDataWithUserId:userid wtid:_curWtid];
        [self requestData:@"?c=wwzj&m=getzjlist" withDictionary:dic1
               withMethod:SHHttpRequestGet];
    }];
    _expertTableView.header = mjHeader;
    
    
    //上拉加载更多
    _expertTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.data == 0) {
            return ;
        }
        DLOG(@"home load more!");
        
       ExpertModel *model = [self.data lastObject];
        
        NSDictionary *dic2 = @{
                               @"id":model.zjid,
                               @"pagesize":@"10"
                               };
        
        [self requestData:@"?c=wwzj&m=getzjlist" withDictionary:dic2 withMethod:SHHttpRequestGet];
    }];

    [self.view addSubview:_expertTableView];
    
}
#pragma mark - clickevent
- (void)back:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 添加子视图 以及添加约束方法
- (void)initlistTableView{
   //左边
    _leftList = [[ListExpertView alloc] initWithFrame:CGRectMake(0,kNavigationBarHeight+kStatusBarHeight+44, kScreenSizeWidth/2,kScreenSizeHeight/2) style:UITableViewStylePlain];
    _leftList.isrigth = NO;
    _leftList.hidden = YES;
    _leftList.data = _leftdata;
    
    __weak AskSpecialistViewController *wself = self;
    _leftList.block = ^(NSString *str,NSString *lxbh){
        
        wself.leftLabel.text = str;
        
        [wself addConstraints];
        
        NSDictionary *dic = @{
                              @"zjlx":lxbh,
                              @"id":@"0",
                              @"pageSize":@"10"

                              };
        
        [wself requestData:@"?c=wwzj&m=getzjlist4lx" withDictionary:dic withMethod:SHHttpRequestGet];
        
    };
    [self.view addSubview:_leftList];
    //右边
    _rigthList = [[ListExpertView alloc] initWithFrame:CGRectMake(kScreenSizeWidth/2,kNavigationBarHeight+kStatusBarHeight+44, kScreenSizeWidth/2, 200)style:UITableViewStylePlain];
    _rigthList.isrigth = YES;
    _rigthList.hidden= YES;
    
    _rigthList.block =^(NSString *str,NSString *number){
        wself.rigthLabel.text = str;
        [wself addConstraints];
        
        NSDictionary *dic = @{
                             @"pxlx":number,
                             @"id":@"0",
                             @"pagesize":@"10",
                             @"zjlx":@"0000"
                             };
        [wself requestData:@"?c=wwzj&m=getzjlist4znpx" withDictionary:dic withMethod:SHHttpRequestGet];
    
    };
    
    _rigthList.data = _rigthdata;
    
    [self.view addSubview:_rigthList];
    

}
- (void)initsubviews
{
    if (_leftView == nil) {
        //左边视图
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0,kStatusBarHeight+ kNavigationBarHeight , kScreenSizeWidth/2, 44)];
        _leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_expert_Sequence"]];
         [_leftView addSubview:_leftImage];
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.numberOfLines = 1;
        _leftLabel.text = @"专家类型";
        _leftLabel.textColor = [UIColor colorWithHexString:@"#33333"];
        _leftLabel.font = kTextFont16;
        [_leftView addSubview:_leftLabel];
        _leftView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth/2, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [_leftView addSubview:line];
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftViewAction)];
        [_leftView addGestureRecognizer:tap];
        
    
        [self.view addSubview:_leftView];
    }
    if (_rigthView == nil){
        //右边视图
        _rigthView = [[UIView alloc] initWithFrame:CGRectMake(kScreenSizeWidth/2,kStatusBarHeight+ kNavigationBarHeight, kScreenSizeWidth/2, 44)];
        
        _rigthImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_expert_type"]];
        [_rigthView addSubview:_rigthImage];
        
        _rigthLabel = [[UILabel alloc] init];
        _rigthLabel.numberOfLines = 1;
        _rigthLabel.text = @"智能排序";
        _rigthLabel.textColor = [UIColor colorWithHexString:@"#33333"];
        _rigthLabel.font = kTextFont16;
        [_rigthView addSubview:_rigthLabel];
        
        _rigthView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth/2, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [_rigthView addSubview:line];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rigthViewAction)];
        [_rigthView addGestureRecognizer:tap];
        
        
        [self.view addSubview:_rigthView];
    }
    
    //添加约束
    [self addConstraints];
}
- (void)addConstraints{
    
    //左边的label
    NSString *leftStr = _leftLabel.text;
   
    CGSize leftsize = [leftStr sizeWithFont:kTextFont16 constrainedToSize:CGSizeMake(MAXFLOAT,21)];
    
   
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_leftView.mas_top).offset(12);
        make.centerX.equalTo(_leftView.mas_centerX);
    }];
    
    
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.top.equalTo(_leftLabel.mas_top);
        make.right.equalTo(_leftLabel.mas_left).offset(-12);
    }];
    
    NSString *rigthStr = _rigthLabel.text;
    
    CGSize rigthsize = [rigthStr sizeWithFont:kTextFont16 constrainedToSize:CGSizeMake(MAXFLOAT,21)];
    [_rigthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_rigthView.mas_top).offset(12);
        make.centerX.equalTo(_rigthView.mas_centerX);
    }];
    
    [_rigthImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.top.equalTo(_rigthLabel.mas_top);
        make.right.equalTo(_rigthLabel.mas_left).offset(-12);
    }];
    
    
   
       ;}
#pragma mark -
- (void)leftViewAction{
    
    _leftList.hidden = !_leftList.hidden;
    
    if (_leftList.hidden ==  NO) {
        _rigthList.hidden = YES;
    }


}
- (void)rigthViewAction{
    _rigthList.hidden =! _rigthList.hidden;
    
    if (_rigthList.hidden ==NO) {
        _leftList.hidden = YES;
    }
  

}

#pragma mark----数据处理
-(void)requestData:(NSString *)url withDictionary:(NSDictionary *)dic withMethod:(NSInteger)type{
    
    [self.data removeAllObjects];

    __weak AskSpecialistViewController *wself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:type subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"code"];
        if ([code integerValue]==1) {//成功
            NSArray *array = [responseObject objectForKey:@"list"];
            
            for (NSDictionary *dic in array) {
                ExpertModel *model = [[ExpertModel alloc] initContentWithDic:dic];
                [self.data addObject:model];
            }
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
    
                wself.expertTableView.data = wself.data.mutableCopy;
                
            });
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}


@end
