

//
//  MineInfoViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineExpertInfoViewController.h"
#import "UserMenuItem.h"
#import "MineInfosCell.h"
#import "MinePhotoCell.h"
#import "MineExpertInfo.h"

@interface MineExpertInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *expertInfoTableView;

@end

@implementation MineExpertInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back:)];
    
    [self setBarTitle:@"个人信息"];
    [self.view addSubview:self.infoTableView];
    
    [self requestExpertInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)requestExpertInfo
{
    //tianjia loading
    [self.view showLoadingWihtText:@"加载中..."];
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=user&m=get_zjinf" parameters:@{@"id":self.info.zjid} prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        MineExpertInfo *expertinfo = [[MineExpertInfo alloc] initWithDictionary:responseObject error:nil];
        [self.view dismissLoading];
        if (expertinfo.code.intValue)
        {
            [self getDataWithExpertInfo:expertinfo];
        }
        else
        {
            [self.view showWeakPromptViewWithMessage:@"请求专家信息失败"];

        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view dismissLoading];
        [self.view showWeakPromptViewWithMessage:@"请求专家信息失败"];
    }];
}


- (void)getDataWithExpertInfo:(MineExpertInfo *)expertInfo
{
    self.infos = [NSMutableArray array];
    UserMenuItem *item = [[UserMenuItem alloc] init];
    item.type = TypeChangePhoto;
    item.title = @"头像";
    item.imageString = expertInfo.usertx;
    [self.infos addObject:item];
    
    UserMenuItem *item1= [[UserMenuItem alloc] init];
    item1.type = TypeContent;
    item1.title = @"姓名";
    item1.subTitle = expertInfo.xm;
    [self.infos addObject:item1];
    
    UserMenuItem *item2= [[UserMenuItem alloc] init];
    item2.type = TypeContent;
    item2.title = @"年龄";
    item2.subTitle = expertInfo.zjnl;
    [self.infos addObject:item2];
    
    UserMenuItem *item3= [[UserMenuItem alloc] init];
    item3.type = TypeContent;
    item3.title = @"专家类型";
    item3.subTitle = expertInfo.zjlxms;
    [self.infos addObject:item3];
    
    UserMenuItem *item4= [[UserMenuItem alloc] init];
    item4.type = TypeContent;
    item4.title = @"擅长作物";
    item4.subTitle = expertInfo.sczwms;
    [self.infos addObject:item4];
    
    UserMenuItem *item5= [[UserMenuItem alloc] init];
    item5.type = TypeContent;
    item5.title = @"工作单位";
    //    item.subTitle = self.info.xm;
    [self.infos addObject:item5];
    
    UserMenuItem *item6= [[UserMenuItem alloc] init];
    item6.type = TypeContent;
    item6.title = @"联系电话";
    //    item.subTitle = self.info.xm;
    [self.infos addObject:item6];
    
    UserMenuItem *item7= [[UserMenuItem alloc] init];
    item7.type = TypeContent;
    item7.title = @"联系地址";
    //    item.subTitle = self.info.xm;
    [self.infos addObject:item7];
    
    UserMenuItem *item8= [[UserMenuItem alloc] init];
    item8.type = TypeContent;
    item8.title = @"自我简介";
    //    item.subTitle = self.info.xm;
    [self.infos addObject:item8];
    
    [self.expertInfoTableView reloadData];
    
}

#pragma mark - click

- (void)back:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - subviews
- (UITableView *)infoTableView
{
    if (!_expertInfoTableView)
    {
        _expertInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yDispaceToTop, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop) style:UITableViewStylePlain];
        _expertInfoTableView.delegate = self;
        _expertInfoTableView.dataSource = self;
        _expertInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _expertInfoTableView;
}

#pragma mark - tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserMenuItem *item = [self.infos objectAtIndex:indexPath.row];
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
    
}

@end
