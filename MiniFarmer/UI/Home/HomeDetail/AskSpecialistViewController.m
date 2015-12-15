//
//  AskSpecialistViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskSpecialistViewController.h"
#import "BaseViewController+Navigation.h"

@interface AskSpecialistViewController ()

@property (nonatomic, strong) UIButton *specialistTypeBT;
@property (nonatomic, strong) UIButton *intelligentSortingBT;

@end

@implementation AskSpecialistViewController


#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back:)];
    [self initsubviews];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - clickevent
- (void)back:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 添加子视图 以及添加约束方法
- (void)initsubviews
{
    [self.view addSubview:self.specialistTypeBT];
    [self.view addSubview:self.intelligentSortingBT];
    
    [self.specialistTypeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(38);
        make.top.equalTo(self.view.mas_top).offset(self.yDispaceToTop + 12);
        make.size.mas_equalTo(CGSizeMake(59, 13));
    }];
    
    [self.intelligentSortingBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.specialistTypeBT.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(59, 13));
        make.right.equalTo(self.view.mas_right).offset(-38);
    }];
}

#pragma mark - 初始化方法
- (UIButton *)specialistTypeBT
{
    if (!_specialistTypeBT)
    {
        _specialistTypeBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specialistTypeBT setTitle:@"专家类型" forState:UIControlStateNormal];
        [_specialistTypeBT setBTFont:kTextFont(13)];
        [_specialistTypeBT setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    }
    return _specialistTypeBT;
}

- (UIButton *)intelligentSortingBT
{
    if (!_intelligentSortingBT)
    {
        _intelligentSortingBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_intelligentSortingBT setBTFont:kTextFont(13)];
        [_intelligentSortingBT setTitle:@"智能排序" forState:UIControlStateNormal];
        [_intelligentSortingBT setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
    return _intelligentSortingBT;
}



@end
