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
    [self setNavigationBarIsHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(Messageback)];
    
    [self initTitleLabel:@"我的消息"];
    
    [self createSubView];
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];
    
}
- (void)Messageback{
  
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)createSubView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    label.font = kTextFont14;
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.text = @"没有任何消息";
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    
    [imgV setImage:[UIImage imageNamed:@"home_question_no_answer"]];
    [self.view addSubview:imgV];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_top).offset(-25);
        make.height.equalTo(@49);
        make.width.equalTo(@49);
        make.centerX.equalTo(label.mas_centerX);
    }];
}



@end
