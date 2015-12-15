//
//  MineChangeInfoViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineChangeInfoViewController.h"

@interface MineChangeInfoViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UITextField *mineTextField;


@end

@implementation MineChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStatusBarColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back)];
    [self setBarTitle:@"我的问题"];
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"a3a3a3"] heigth:kLineWidth];
    [self addSubviews];
    [self addGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - subviews

- (void)addSubviews
{
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.mineTextField];
    
    [self.mineTextField setTextFieldLeftPaddingForWidth:16];

    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    
    [self.mineTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.top.equalTo(self.view.mas_top).offset(self.yDispaceToTop + 20);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.equalTo(@44);

    }];
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
        [_sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UITextField *)mineTextField
{
    if (!_mineTextField)
    {
        _mineTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _mineTextField.layer.cornerRadius = 8;
        _mineTextField.layer.borderColor = [UIColor colorWithHexString:@"e4e4e4"].CGColor;
        _mineTextField.layer.borderWidth = kLineWidth; //也就是0.5dp
        _mineTextField.textColor = [UIColor colorWithHexString:@"333333"];
        _mineTextField.font = kTextFont(16);
        [_mineTextField setBackgroundColor:[UIColor whiteColor]];
        _mineTextField.delegate = self;
    }
    return _mineTextField;
}


- (void)send:(UIButton *)btn
{
    if (!self.mineTextField.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"不能为空"];
        
    }
    
    NSString *subUrl = @"?c=user&m=edit_personal";
    NSString *userid = [[MiniAppEngine shareMiniAppEngine]userId];
    // 这里怎么区分 传入的是哪些个字段
    NSDictionary *dic = @{@"userid":userid,@"fieldname":self.item.filename,@"fieldvalue":self.mineTextField.text};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:subUrl parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        BaseModel *baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.code.intValue)
        {
            [self.view showWeakPromptViewWithMessage:@"修改成功"];
            [self back];
            self.item.subTitle = self.mineTextField.text;
            self.changeInfoSuceess(self.item);
        }
        else
        {
            [self.view showWeakPromptViewWithMessage:@"修改失败"];
 
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view showWeakPromptViewWithMessage:@"修改失败"];
    }];
}


#pragma mark - UITextFiledDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
        [_sendButton setEnabled:textField.text.length ? YES : NO];
        return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
@end
