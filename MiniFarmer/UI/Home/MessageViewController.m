//
//  MessageViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MessageViewController.h"
#import "BaseViewController+Navigation.h"

@implementation MessageViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(backBtnPressed)];
    [self initTitleLabel:@"我的消息"];
    
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"http://www.enbs.com.cn/apps_test/uploads/twimg/2015/12/11/14497968194469.jpg"];
    
    [imageV sd_setImageWithURL:url placeholderImage:nil];
    [self.view addSubview:imageV];
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self setNavigationBarIsHidden:NO];

    //tabview.hidden = YES;
    
    //[self initNavigationbgView:[UIColor grayColor]];
    
}
- (void)backBtnPressed{
  
    [self.navigationController popToRootViewControllerAnimated:YES];

}



@end
