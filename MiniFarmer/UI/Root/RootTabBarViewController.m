//
//  RootTabBarViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "AskViewController.h"
#import "LoginViewController.h"

#define kBaseTabBarButtonTag    5000
#define kTabBarItemCount    3

@interface RootTabBarViewController ()
{
   HomeViewController *homeVC;
    AskViewController *askVC;
    MineViewController *mineVC;
    
    UIButton *_previousBtn;
    UIButton *_homeBtn;
    NSUInteger _index;//用于记录上一个点击控制器的下标
    
    
    //AskViewController *askVC;
}
@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubviews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificatopnAction:) name:@"homeViewAppear" object:nil];
    _tabBarView.hidden = NO;
    
    //默认选中第一个
    _homeBtn.enabled = NO;
    _previousBtn = _homeBtn;
    _index = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)notificatopnAction:(NSNotificationCenter *)notification{
    _tabBarView.hidden =NO;

}

#pragma mark- private
- (void)addSubviews
{
    homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    
    
   // UINavigationController *askNav = [[UINavigationController alloc] initWithRootViewController:askVC];
     
    
    mineVC = [[MineViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc]initWithRootViewController:mineVC];
    
    
    self.viewControllers = @[homeNav
                             ,mineNav];
    self.delegate = self;
    self.tabBar.hidden = YES;
    
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-kBottomTabBarHeight, CGRectGetWidth(self.view.bounds), kBottomTabBarHeight)];
    _tabBarView.tag = 201;
    [self.view addSubview:_tabBarView];
    _tabBarView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [_tabBarView addSubview:line];
    
    //添加底部按钮
    _homeBtn = [self buttonWithNormalName:@"root_btn_home_nm" andSelectName:@"root_btn_home_sel" andTitle:@"首页" andIndex:0];
    [_tabBarView addSubview:_homeBtn];
    
    UIButton *askBtn = [self buttonWithNormalName:@"root_btn_ask_sel" andSelectName:@"root_btn_ask_sel" andTitle:nil andIndex:1];
    [_tabBarView addSubview:askBtn];
    
     UIButton *mineBtn =[self buttonWithNormalName:@"root_btn_mine_nm" andSelectName:@"root_btn_mine_sel" andTitle:@"我的" andIndex:2];
    [_tabBarView addSubview:mineBtn];
}

//创建一个按钮
- (UIButton *)buttonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    CGFloat buttonW = _tabBarView.frame.size.width / kTabBarItemCount;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index+kBaseTabBarButtonTag;
    button.frame = CGRectMake(buttonW *index, 0, buttonW, buttonH);
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:selected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
//    button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
//    button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
    button.titleLabel.font = [UIFont systemFontOfSize:10]; // 设置标题的字体大小
    [button setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#488bff"] forState:UIControlStateDisabled];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+6,-button.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [button setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -button.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不变
    return button;
}

//按钮被点击时调用
- (void)changeViewController:(UIButton *)sender
{   askVC =nil;
    //如果选中的是1 并且没有登录的情况下 就在原来的页面弹出一个登录的页面
    if (sender.tag - kBaseTabBarButtonTag == 1
       )
    {
        
     if (![[MiniAppEngine shareMiniAppEngine] isLogin]) {
            [self presentLogin];
            return;
        }else {
            
            if (_index == 0) {
                 askVC = [[AskViewController alloc] init];
                [homeVC.navigationController pushViewController:askVC animated:YES];
                return;
            }else{
                askVC = [[AskViewController alloc] init];
                [mineVC.navigationController pushViewController:askVC animated:YES];
                return;
            }
        }
    }
    
    if (sender.tag- kBaseTabBarButtonTag==2) {
        self.selectedIndex = 1;
    }else{
        self.selectedIndex = sender.tag-kBaseTabBarButtonTag; //切换不同控制器的界面
    }
        NSLog(@"self.selectedIndex%ld",(unsigned long)self.selectedIndex);
    
    _index = sender.tag - kBaseTabBarButtonTag;

    self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:self.selectedIndex];
    sender.enabled = NO;
    if (_previousBtn != sender) {
        _previousBtn.enabled = YES;
        
    }
    _previousBtn = sender;
    
}

- (void)presentLogin
{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.loginBackBlock = ^(){
        [self changeIndexToSelected:0];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)changeIndexToSelected:(NSInteger)selectedIndex
{
    UIButton *btn = [_tabBarView.subviews objectAtIndex:selectedIndex];
    [self changeViewController:btn];
    
    
}
- (void)tabBarViewhidden{

    _tabBarView.hidden = YES;

}
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}



#pragma mark- UITabBarControllerDelegate
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    return YES;
//}

@end
