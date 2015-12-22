//
//  MethodDetailViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MethodDetailViewController.h"
#import "BaseViewController+Navigation.h"
#import "commentView.h"
#import "DetailView.h"
#import "MethodDetailModel.h"
#import "TableViewCell.h"
#import "XgpfModel.h"
#import "PfcommentModel.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface MethodDetailViewController ()

@property (nonatomic,strong)NSString *curMethodId;
@property (nonatomic,strong)UIView *commentView;
@property (nonatomic,strong)DetailView *detailView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong)NSString *identify1;
@property (nonatomic,strong)NSString *identify2;
@property (nonatomic,strong)NSMutableArray *arr1;
@property (nonatomic,strong)NSMutableArray *arr2;
@property (nonatomic,strong)MethodDetailModel *model;


@end

@implementation MethodDetailViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(backBtnPressed)];
    
    [self setBarTitle:@""];
    [self addsubViews];
    
    [self requestdata];
    
    _data = [NSMutableArray array];
    _arr1 = [NSMutableArray array];
    _arr2 = [NSMutableArray array];

}


- (void)addsubViews{
    
    [self setTabbar];
    
    
    [self loadTableView];
}


- (void)loadTableView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _detailView.bounds.size.height + kStatusBarHeight + kNavigationBarHeight , kScreenSizeWidth, kScreenSizeHeight - kStatusBarHeight - kNavigationBarHeight -44) style:UITableViewStylePlain];

    
    _tableView.dataSource = self;
    _tableView.delegate = self;


    _detailView = [[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:self options:nil].lastObject;
    
//    _detailView.frame = CGRectMake(0, kStatusBarHeight + kNavigationBarHeigth, kScreenSizeWidth, _detailView.height);
    
    _detailView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    _tableView.tableHeaderView = _detailView;

//    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:_tableView];
    
    _identify1 = @"xgpf";
    
    _identify2 = @"comment";
    
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    
    [_tableView registerNib:nib forCellReuseIdentifier:_identify2];

    
}


- (void)setTabbar{
    
    _commentView = [[NSBundle mainBundle] loadNibNamed:@"commentView" owner:self options:nil].lastObject;
    _commentView.frame = CGRectMake(0, kScreenSizeHeight - kBottomTabBarHeight, kScreenSizeWidth, kBottomTabBarHeight);
    _commentView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    [self.view addSubview:_commentView];
    
}

- (void)requestdata {
    
    
    NSDictionary *dicPar = @{
                             @"pfid":@165,
                             @"pagesize":@"1",
                             };
    
    __weak MethodDetailViewController *wself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=wzpf&m=getpf" parameters:dicPar prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!responseObject) {
                return ;
            }
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *result = responseObject;
                BOOL code = [[result objectForKey:@"code"] boolValue];
                NSString *msg = [result objectForKey:@"msg"];
                DLOG(@"code = %d,msg = %@",code,msg);
                if (!code) {
                    //显示加载错误提示
                    return;
                }
                
                else{
                    
                    NSMutableDictionary *dic = responseObject[@"pf"];
                    
                    _model = [[MethodDetailModel alloc] initContentWithDic:dic];
                    _detailView.model = _model;
                    //                [wself.data addObject:_model];
                    
                    NSMutableArray *arr1 = responseObject[@"xgpflist"];
                    for (NSDictionary *dic in arr1) {
                        
                        xgpfModel *model = [[xgpfModel alloc] initContentWithDic:dic];
                        
                        [wself.data addObject:model];
                    }
                    
                    _arr2 = responseObject[@"commentlist"];
                    
                    for (NSDictionary *dic in _arr2) {
                        PfcommentModel *model = [[PfcommentModel alloc]    initContentWithDic:dic];
                        
                        
                        [wself.data addObject:model];
                    }
                    [wself.tableView reloadData];
                }
            }
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


- (void)backBtnPressed{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell  *cell;
    
    if (_arr2.count != 0) {
     cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];

        cell.model2 = _data[indexPath.row];
        return cell;
    }

    return nil;
}

//返回单元格的高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heigth =[tableView fd_heightForCellWithIdentifier:_identify2 configuration:^(TableViewCell * cell) {
        
        cell.model2 = _data[indexPath.row];
        
    }];
    
    return   heigth;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _headView = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil].lastObject;
    _headView.frame = CGRectMake(0, 0, kScreenSizeWidth, 44);
    _headView.layer.borderWidth = 0.5;
    _headView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#dddddd"]);
    
    return _headView;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

@end
