//
//  DiseaDetailViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DiseaDetailViewController.h"
#import "ShareView.h"
#import "DiseaseCell.h"
#import "DrugDetailView.h"
#import "StudyHeaderView.h"
#import "UserInfo.h"
#import "DieaseModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RootTabBarViewController.h"
//#import "BaseViewController+Navigation.h"

@interface DiseaDetailViewController ()

@property(nonatomic,strong)DieaseModel *model;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation DiseaDetailViewController{
    ShareView *_topView;

    StudyHeaderView *_headerView;
    NSString *identfy;
    
    DrugDetailView *_drugdetailView;
    
    NSArray *images;
    
    NSNumber *_iscoll;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self _createSubView];
    //self.edgesForExtendedLayout = UIRectEdgeAll;
                                 
}
- (void)_createSubView{
    [self.view showLoadingWihtText:@"加载中"];
   //1.创建头视图上面的导航条
    _topView = [[NSBundle mainBundle]loadNibNamed:@"ShareView" owner:self   options:nil].lastObject;
    _topView.frame = CGRectMake(0, kStatusBarHeight, kScreenSizeWidth, kNavigationBarHeight);
    _topView.backgroundColor = [UIColor clearColor];
    
   //2.创建滑动视图的头视图
    _headerView = [[NSBundle mainBundle] loadNibNamed:@"StudyHeaderView" owner:self options:nil].lastObject;
    [_headerView addSubview:_topView];
   //3.创建滑动视图
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.hidden = YES;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    //[self.view insertSubview:_tableView atIndex:0];
    [self.view addSubview:_tableView];
   
    
    

    //注册单元格
    identfy = @"diseacell";
    UINib *nib = [UINib nibWithNibName:@"DiseaseCell"bundle:nil];
    
    [_tableView registerNib:nib forCellReuseIdentifier:identfy];
    //创建单元格的尾部视图
    
    _drugdetailView =[[DrugDetailView alloc] initWithFrame: CGRectMake(0, 0, kScreenSizeWidth, 40) ];

    _tableView.tableFooterView = _drugdetailView;
    

}
#pragma mark -----UITableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiseaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identfy forIndexPath:indexPath];
    cell.title = self.data[indexPath.row];
    if (_model==nil) {
        return cell;
    }
    if (indexPath.row==0) {
        cell.comment = _model.whtz;
    }else if(indexPath.row ==1){
        cell.comment = _model.fsgl;
    }else if(indexPath.row ==2){
        cell.comment = _model.fzff;
    }
    
    
    return cell;


}
//设置头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 12)];
        view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        
        return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 12;

}
//自动计算单元格高度
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_model ==nil) {
        return 100;
    }
    CGFloat height = [tableView fd_heightForCellWithIdentifier:identfy cacheByIndexPath:indexPath configuration:^(DiseaseCell *cell) {
        if (indexPath.row ==0) {
            cell.comment = _model.whtz;
        }else if(indexPath.row ==1){
        
            cell.comment = _model.fsgl;
        }else if(indexPath.row ==2){
            cell.comment = _model.fzff;
        
        }
        
    }];
    return   height;

}

/*
- (void)viewWillAppear:(BOOL)animated{
    RootTabBarViewController *rootVC = (RootTabBarViewController *)self.tabBarController;
    [rootVC tabBarViewhidden];
}
 */

#pragma mark ---数据处理
- (void)setBchid:(NSString *)bchid{
    _bchid = bchid;
    [self requestData];
   
    
}

- (void)requestData{
    
    NSString *userid =[UserInfo shareUserInfo].userId;
    if (userid == nil) {
       userid = @"0";
    }

    NSDictionary *dic = @{
                          @"bchid":_bchid,
                          @"userid":userid
                          };
    
    
    __weak DiseaDetailViewController *weself = self;
    
    
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=wxjs&m=getbchinfo" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.view dismissLoading];
        _tableView.hidden = NO;
        
        NSDictionary *jsonDic = responseObject[@"bchxq"];
       _model = [[DieaseModel alloc] initContentWithDic:jsonDic];
        images = responseObject[@"images"];
        _iscoll = responseObject[@"iscoll"];
       
        [weself dealData];
        
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)dealData{
    
    _headerView.model = _model;
    _headerView.images = images.mutableCopy;
    

    _tableView.tableHeaderView = _headerView;
    _topView.model = _model;
    _topView.iscoll = _iscoll;
    self.data = @[@"为害特征",@"发生规律",@"防治方法"];
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
