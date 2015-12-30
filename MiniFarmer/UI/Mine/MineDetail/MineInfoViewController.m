

//
//  MineInfoViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineInfoViewController.h"
#import "UserMenuItem.h"
#import "MineInfosCell.h"
#import "MinePhotoCell.h"
#import "MineChangeInfoViewController.h"
#import "MineChangeTXController.h"
#import "UserInfo.h"


@interface MineInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *infoTableView;

@end

@implementation MineInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back:)];
    [self setStatusBarColor:[UIColor colorWithHexString:@"#ffffff"]];
    
    if (self.type == YES) {
        
           }else{
    
        //[self getcommonData];
    }
  
    
    [self.view addSubview:self.infoTableView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - click

- (void)back:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - subviews
- (UITableView *)infoTableView
{
    if (!_infoTableView)
    {
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yDispaceToTop, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop) style:UITableViewStylePlain];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _infoTableView;
}


#pragma mark---
//当是个人信息加载如下的信息
- (void)getcommonData
{
    self.infos = [NSMutableArray array];
    
    UserMenuItem *item = [[UserMenuItem alloc] init];
    item.type = TypeChangePhoto;
    item.title = @"头像";
    item.imageString = self.info.usertx;
    [self.infos addObject:item];
    
    UserMenuItem *item1= [[UserMenuItem alloc] init];
    item1.type = TypeContent;
    item1.title = @"昵称";
    item1.subTitle = self.info.xm;
    item1.filename = @"xm";
    [self.infos addObject:item1];
    
    UserMenuItem *item2= [[UserMenuItem alloc] init];
    item2.type = TypeContent;
    item2.title = @"邀请码";
    item2.filename = @"icode";
    item2.subTitle = self.info.icode;
    [self.infos addObject:item2];
    
    UserMenuItem *item3= [[UserMenuItem alloc] init];
    item3.type = TypeContent;
    item3.title = @"位置";
    item3.filename = @"location";
    item3.subTitle = self.info.location;
    [self.infos addObject:item3];
    
    UserMenuItem *item4= [[UserMenuItem alloc] init];
    item4.type = TypeContent;
    item4.title = @"职业";
    item4.filename = @"jsylx";
    item4.subTitle = self.info.jsylx;
    
    //    item4.subTitle = self.info.zc;
    [self.infos addObject:item4];
    
    UserMenuItem *item5= [[UserMenuItem alloc] init];
    item5.type = TypeContent;
    item5.title = @"种植作物";
    
    item5.subTitle = self.info.zzzw;
    item5.filename = @"zzzw";
    [self.infos addObject:item5];
    
    UserMenuItem *item6= [[UserMenuItem alloc] init];
    item6.type = TypeContent;
    item6.title = @"种植面积";
    item6.filename = @"zzmj";
    
    item6.subTitle = self.info.zzmj;
    [self.infos addObject:item6];
}
//当是专家信息加载如下信息
- (void)getexpertData{
    self.infos = [NSMutableArray array];
    
    UserMenuItem *item = [[UserMenuItem alloc] init];
    item.type = TypeChangePhoto;
    item.title = @"头像";
    item.imageString = self.model.usertx;
    [self.infos addObject:item];
    
    
    UserMenuItem *item1= [[UserMenuItem alloc] init];
    item1.type = TypeContent;
    item1.title = @"真实姓名";
    item1.subTitle = self.model.xm;
    item1.filename = @"xm";
    [self.infos addObject:item1];
    
    UserMenuItem *item2= [[UserMenuItem alloc] init];
    item2.type = TypeContent;
    item2.title = @"年龄";
    item2.filename = @"zjnl";
    item2.subTitle = self.model.zjnl;
    [self.infos addObject:item2];
    
    UserMenuItem *item3= [[UserMenuItem alloc] init];
    item3.type = TypeContent;
    item3.title = @"地址";
    item3.filename = @"dz";
    item3.subTitle = self.model.dz;
    [self.infos addObject:item3];
    
    UserMenuItem *item4= [[UserMenuItem alloc] init];
    item4.type = TypeContent;
    item4.title = @"联系电话";
    item4.filename = @"mobile";
    item4.subTitle = self.model.mobile;
    
    //    item4.subTitle = self.info.zc;
    [self.infos addObject:item4];
    
    UserMenuItem *item5= [[UserMenuItem alloc] init];
    item5.type = TypeContent;
    item5.title = @"专家类型";
    item5.subTitle = self.model.zjlxms;
    item5.filename = @"zjlxms";
    [self.infos addObject:item5];
    
    UserMenuItem *item6= [[UserMenuItem alloc] init];
    item6.type = TypeContent;
    item6.title = @"擅长作物";
    item6.filename = @"sczwms";
    item6.subTitle = self.model.sczwms;
    [self.infos addObject:item6];
    
    UserMenuItem *item7= [[UserMenuItem alloc] init];
    item7.type = TypeContent;
    item7.title = @"工作单位";
    item7.filename = @"gzdw";
    item7.subTitle = self.model.gzdw;
    [self.infos addObject:item7];
    
    UserMenuItem *item8= [[UserMenuItem alloc] init];
    item8.type = TypeContent;
    item8.title = @"个人简介";
    item8.filename = @"zjjs";
    item8.subTitle = self.model.zjjs;
    [self.infos addObject:item8];
    

}
#pragma mark - tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserMenuItem *item = [self.infos objectAtIndex:indexPath.row];
    //类型是改变图片的
    if (item.type == TypeChangePhoto)
    {
        MinePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"minePhotoCell"];
        if (!cell)
        {
            cell = [[MinePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"minePhotoCell"];
        }
        [cell refreshDataWithModel:item];
        return cell;
    }
    else if (item.type == TypeContent)
    {
        MineInfosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineinfosCell"];
        if (!cell)
        {
            cell = [[MineInfosCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineinfosCell"];
        }
        NSString *title = item.title;
        if ([title isEqualToString:@"邀请码"]){
            cell.imageIshidden = YES;
        }
        if ([title isEqualToString:@"真实姓名"]){
            cell.imageIshidden = YES;
        }
        if ([title isEqualToString:@"位置"]){
            cell.imageIshidden = YES;
        }
        [cell refreshDataWithModel:item];
        return cell;

    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserMenuItem *item  = [self.infos objectAtIndex:indexPath.row];
    if (item.type == TypeChangePhoto)
    {
        return [MinePhotoCell cellHeightWihtModel:nil];
    }
    else if (item.type == TypeContent)
    {
        return [MineInfosCell cellHeightWihtModel:nil];
    }
    else
    {
        return 0;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserMenuItem *item = [self.infos objectAtIndex:indexPath.row];
    NSString *title = item.title;
    if ([title isEqualToString:@"邀请码"]){
        return;
    }
    if ([title isEqualToString:@"真实姓名"]){
        return;
    }
    if ([title isEqualToString:@"位置"]){
        return;
    }
    __weak MineInfoViewController *weakself = self;
   
    if (indexPath.row == 0) {//跳转到修改头像的控制器
        
        UserMenuItem *item = [self.infos objectAtIndex:indexPath.row];
        MineChangeTXController *changeTXVC = [[MineChangeTXController alloc] init];
        changeTXVC.zjid = self.model.zjid;
        changeTXVC.url = item.imageString;
        [self.navigationController pushViewController:changeTXVC animated:YES];
    }else{
        MineChangeInfoViewController *changeVC = [[MineChangeInfoViewController alloc] init];
        [changeVC initTitleLabel:item.title];
        changeVC.zjid = self.model.zjid;
        changeVC.item = item;
        changeVC.index = indexPath.row;
        
        changeVC.changeInfoSuceess = ^(UserMenuItem *item){
            
            MineInfosCell *cell = [weakself.infoTableView cellForRowAtIndexPath:indexPath];
            
            [cell refreshDataWithModel:item];
        };
        [self.navigationController pushViewController:changeVC animated:YES];
    }
}

#pragma mark --- 数据处理
- (void)setType:(BOOL)type{
    _type = type;
    if (_type ==YES) {  //专家信息
        NSDictionary *dic =@{
                             @"id":self.info.zjid
                             };
        [self requesetData:@"?c=user&m=get_zjinf" withDic:dic];
        
    }else{ //普通用户信息
        NSString *userid = [UserInfo shareUserInfo].userId;
        
        NSDictionary *dic = @{
                              @"userid":userid
                              };
        [self requesetData:@"?c=user&m=personal_data" withDic:dic];

    }

}
- (void)requesetData:(NSString *)url withDic:(NSDictionary *)dic{
    
    __weak MineInfoViewController *wself = self;
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *code = [responseObject objectForKey:@"code"];
        
        if ([code integerValue]== 1) {
            
            if (wself.type == YES) {
                NSDictionary *dic = [responseObject objectForKey:@"zj"];
                
                wself.model = [[ExpertModel alloc] initContentWithDic:dic];
                //回到主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [wself getexpertData];
                    
                    [wself.infoTableView  reloadData];
                });
            }else{
            
            wself.info = [[MineInfos alloc] initWithDictionary:responseObject error:nil];
                //回到主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [wself getcommonData];
                    [wself.infoTableView  reloadData];
                });
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
@end
