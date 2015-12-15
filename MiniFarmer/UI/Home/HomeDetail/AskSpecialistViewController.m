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

@interface AskSpecialistViewController ()

@property (nonatomic ,strong) SeachView *searchView;
@property (nonatomic, strong) UIButton *specialistTypeBT;
@property (nonatomic, strong) UIButton *intelligentSortingBT;

@end

@implementation AskSpecialistViewController


#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.view.backgroundColor =[UIColor colorWithHexString:@"#ffffff"];
    [self setNavigationBarIsHidden:NO];
   
    //初始化导航栏
    [self setNavigation];
    
    [self initsubviews];
    
}
- (void)setNavigation{
    //1.搜索栏
    _searchView  = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    _searchView.frame = CGRectMake(35,kStatusBarHeight , kScreenSizeWidth-35,kNavigationBarHeigth);
    _searchView.imageNmae = @"home_btn_message_nm";
    _searchView.isSearch = NO;
    _searchView.index = 3;
    
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
    
    CGFloat  weigth = kScreenSizeWidth/2;
    
    
    
    
}

#pragma mark - 初始化方法
- (UIButton *)specialistTypeBT
{
    if (!_specialistTypeBT)
    {
        _specialistTypeBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specialistTypeBT setTitle:@"专家类型" forState:UIControlStateNormal];
        [_specialistTypeBT setBTFont:kTextFont(16)];
        [_specialistTypeBT setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
    return _specialistTypeBT;
}

- (UIButton *)intelligentSortingBT
{
    if (!_intelligentSortingBT)
    {
        _intelligentSortingBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_intelligentSortingBT setBTFont:kTextFont(16)];
        [_intelligentSortingBT setTitle:@"智能排序" forState:UIControlStateNormal];
        [_intelligentSortingBT setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
    return _intelligentSortingBT;
}



@end
