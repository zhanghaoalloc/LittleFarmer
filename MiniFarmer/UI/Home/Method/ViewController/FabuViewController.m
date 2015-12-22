//
//  FabuViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "FabuViewController.h"
#import "BaseViewController+Navigation.h"
#import "PftitleView.h"
@interface FabuViewController ()

@property (nonatomic,strong)UIButton *sendButton;
@property (nonatomic,strong)PftitleView *pftitleView;
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation FabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBarLeftDefualtButtonWithTarget:self action:@selector(backBtnPressed)];
    [self setBarTitle:@"添加配方"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addsubViews];
}

- (void)addsubViews{
    
//    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.pftitleView];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    
    self.scrollView.frame = self.view.frame;
    
    self.pftitleView.frame = CGRectMake( 12, kStatusBarHeight + kNavigationBarHeight, kScreenSizeWidth, 44);

}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
    
}
- (PftitleView *)pftitleView{
    
    if (!_pftitleView) {
        _pftitleView = [[PftitleView alloc] initWithFrame:CGRectZero];
    }
   
    return _pftitleView;
}
- (UIButton *)sendButton
{
    if (!_sendButton)
    {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_no_enable_nm"] forState:UIControlStateDisabled];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_hl"] forState:UIControlStateHighlighted];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_enable_nm"] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_sendButton setEnabled:NO];
        
//        [_sendButton addTarget:self action:@selector(sendAsk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (void)backBtnPressed{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
