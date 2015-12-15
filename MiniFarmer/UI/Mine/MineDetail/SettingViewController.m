//
//  SettingViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingModel.h"
#import "SettinSpaceCell.h"
#import "SettingAbountCell.h"
#import "SettingQuitLoginCell.h"
#import "AboutViewController.h"
#import "RecomentViewController.h"

typedef enum
{
    CellTypeAbout = 1,
    CellTypeRecoment = 2,
    CellTypeQuitlt = 4
    
}CellType;

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *settingTab;
@property (nonatomic, strong) NSMutableArray *settingArr;

@end

@implementation SettingViewController

- (instancetype)init
{
    if (self = [super init])
    {
       self.settingArr = [self models];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarTitle:@"设置"];
    [self.view addSubview:self.settingTab];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
}

#pragma mark - getModels

- (NSMutableArray *)models
{
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:3];
    
    NSArray *tempArr = @[@"",@"关于小农人",@"意见反馈",@"",@"退出登录"];
    NSArray *heigth = @[@15,@50,@50,@30,@44];
    NSArray *classesArr = @[@"SettinSpaceCell",@"SettingAbountCell",@"SettingAbountCell",@"SettinSpaceCell",@"SettingQuitLoginCell"];

    for (int i = 0;i<tempArr.count ;i++)
    {
        SettingModel *settingModel = [[SettingModel alloc] init];
        settingModel.title = [tempArr objectAtIndex:i];
        settingModel.heigth = [heigth objectAtIndex:i];
        settingModel.classString = [classesArr objectAtIndex:i];
        [models addObject:settingModel];
    }
    return models;
}

#pragma mark - subviews

- (void)addSubviews
{
    
}

- (UITableView *)settingTab
{
    if (!_settingTab)
    {
        _settingTab = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight + kLineWidth, kScreenSizeWidth, kScreenSizeHeight - kStatusBarHeight - kNavigationBarHeight - kLineWidth) style:UITableViewStylePlain];
        [_settingTab setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
        _settingTab.separatorStyle = NO;
        _settingTab.delegate = self;
        _settingTab.dataSource = self;
    }
    return _settingTab;
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingModel *model = [_settingArr objectAtIndex:indexPath.row];
    Class classObject = NSClassFromString(model.classString);
    return [classObject cellHeightWihtModel:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingModel *model = [_settingArr objectAtIndex:indexPath.row];
    Class classObject = NSClassFromString(model.classString);
    id cell = [tableView dequeueReusableCellWithIdentifier:model.classString];
    if (!cell) {
        cell = [[classObject alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:model.classString];
    }
    [cell refreshDataWithModel:model];
    if (indexPath.row == CellTypeAbout)
    {
        [(SettingAbountCell *)cell setLineDispaceToLeft:12];
        [(SettingAbountCell *)cell setStringColor:@"e4e4e4"];
    }
    else if (indexPath.row == CellTypeRecoment)
    {
        [(SettingAbountCell *)cell setLineDispaceToLeft:0];
        [(SettingAbountCell *)cell setStringColor:@"dddddd"];
    }
    else if (indexPath.row == CellTypeQuitlt)
    {
        __weak SettingViewController *wself = self;
        [(SettingQuitLoginCell *)cell setTapQuilt:^(UIButton *btn){
            [wself tapQuitlLogin];
            
        }];
    }
    return cell;

}

- (void)tapQuitlLogin
{
    if ([MiniAppEngine shareMiniAppEngine].isLogin)
    {
        [[MiniAppEngine shareMiniAppEngine] clearUserLoginInfos];
        [[MiniAppEngine shareMiniAppEngine] saveInfos];
        [self.view showWeakPromptViewWithMessage:@"退出登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
   // 如果没有登陆的情况
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == CellTypeAbout)
    {
        AboutViewController *aboutnVC = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutnVC animated:YES];
    }
    else if (indexPath.row == CellTypeRecoment)
    {
        RecomentViewController *recommentVC = [[RecomentViewController alloc] init];
        [self.navigationController pushViewController:recommentVC animated:YES];
    }
}

@end
