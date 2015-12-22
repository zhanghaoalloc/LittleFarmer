

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

@interface MineInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *infoTableView;

@end

@implementation MineInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back:)];
    
    [self setBarTitle:@"个人信息"];
    
    [self getData];
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

- (void)getData
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
        if (indexPath.row==2||indexPath.row == 3) {
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
    NSInteger index = indexPath.row;
    if (index==2||index == 3) {
        return;
    }
    __weak MineInfoViewController *weakself = self;
    UserMenuItem *item = [self.infos objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {//跳转到修改头像的控制器
        
        UserMenuItem *item = [self.infos objectAtIndex:indexPath.row];
        MineChangeTXController *changeTXVC = [[MineChangeTXController alloc] init];
        changeTXVC.url = item.imageString;
        [self.navigationController pushViewController:changeTXVC animated:YES];
    }else{
        MineChangeInfoViewController *changeVC = [[MineChangeInfoViewController alloc] init];
        [changeVC initTitleLabel:item.title];
        changeVC.item = item;
        
        changeVC.index = indexPath.row;
        
        changeVC.changeInfoSuceess = ^(UserMenuItem *item){
            
            MineInfosCell *cell = [weakself.infoTableView cellForRowAtIndexPath:indexPath];
            
            [cell refreshDataWithModel:item];
        };
        [self.navigationController pushViewController:changeVC animated:YES];
    }
}

@end
