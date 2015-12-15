//
//  StudtydetailViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "StudtydetailViewController.h"
#import "StudymoreCell.h"
#import "StudydetailCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UIView+FrameCategory.h"
#import "StudyModel.h"
#import "DiseaPicViewController.h"
@interface StudtydetailViewController ()
@property(nonatomic ,strong)NSMutableArray *data;

@end



@implementation StudtydetailViewController{
    
    
    NSString *identify1;
    NSString *identify2;



}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeAll;
    //self. automaticallyAdjustsScrollViewInsets= NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    //2,创建子视图
    [self _addSubViews];
    
   
    
}
- (void)viewWillAppear:(BOOL)animated{
   // [self _requestData];

}
- (void)_addSubViews{
    
    //添加显示加载中的视图
    [self.view showLoadingWihtText:@"加载中"];
    
    
    //1.创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight-kStatusBarHeigth-kNavigationBarHeight-42) style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.bounces =NO;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    
    //2.注册单元格
    identify1 = @"morecell";
    identify2 = @"detailcell";
    
    
    UINib *nib1 = [UINib nibWithNibName:@"StudymoreCell" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:identify1];
    
    
    [_tableView registerClass:[StudydetailCell class] forCellReuseIdentifier:identify2];

}
#pragma mark --UITableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return self.data.count/2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
     StudymoreCell *   cell = [tableView dequeueReusableCellWithIdentifier:identify1 forIndexPath:indexPath];
        
        cell.model = _data[indexPath.section];
        return cell;
    }else{
        StudydetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
        
        cell.isStudymore = NO;
        cell.model = _data[indexPath.section];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }
    CGFloat weiht = (kScreenSizeWidth-36)/3;
    
    return weiht;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.000001;
    }else{
        return 6;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 6;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 6)];
    view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    return view;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 6)];
    view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    return view;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        StudyModel *model  = self.data[indexPath.section];
        
        DiseaPicViewController *diseaVC = [[DiseaPicViewController alloc] init];
        diseaVC.tabBarController.hidesBottomBarWhenPushed = YES;
        
        [diseaVC initTitleLabel:model.twoclassname];
        diseaVC.twoclassid = model.twoclassid;

        [self.navigationController pushViewController:diseaVC animated:YES];
        
    }    


}
#pragma mark ---数据处理
- (void)setBigid:(NSString *)bigid{
    _bigid = bigid;
    [self _requestData];
}

- (void)_requestData{
    
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    
    NSDictionary *dic = @{
                          @"bigclassid":_bigid
                          
                          };

   
    __weak StudtydetailViewController *weself = self;
    [[SHHttpClient defaultClient]requestWithMethod:SHHttpRequestGet subUrl:@"?c=wxjs&m=getwxjslist" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(),^{
            [self.view dismissLoading];
            
            _tableView.hidden = NO;
            NSArray * arrary = responseObject[@"list"];
            for (NSDictionary *dic in arrary) {
                StudyModel *model = [[StudyModel alloc ] initContentWithDic:dic];
                [weself.data addObject:model];
                
            }
             
            [weself.tableView reloadData];
            
        });
        return ;
    
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
      
  }];

}
@end
