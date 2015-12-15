//
//  MineBaseViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseViewController.h"

@interface MineBaseViewController ()

@end

@implementation MineBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(popVC)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarIsHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavigationBarIsHidden:NO];
}


#pragma mark - click
- (void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
