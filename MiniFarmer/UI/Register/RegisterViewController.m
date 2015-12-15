//
//  RegisterViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/2.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "RegisterViewController.h"
#import "YHSMSCodeButton.h"
#import "BaseViewController+Navigation.h"
#import "UIScrollView+LGKeyboard.h"
#import "RegisterModel.h"

#define kDispaceToLeft 16
#define kDispaceToButtons 8
@interface RegisterViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *phoneTF;
@property (strong, nonatomic) UITextField *passwordTF;
@property (strong, nonatomic) UITextField *againPasswordTF;
@property (strong, nonatomic) UITextField *verificationCodeTF;

@property (strong, nonatomic) YHSMSCodeButton *getSMSCodeBtn;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIButton *protocalBtn;

@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];

    [self initSubViews];
    
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(dismissRegisterVCAction)];
    [self setBarTitle:@"用户注册"];
    
    [self setLayerWithView:self.phoneTF];
    [self setLayerWithView:self.passwordTF];
    [self setLayerWithView:self.againPasswordTF];
    [self setLayerWithView:self.verificationCodeTF];
    
    [self.phoneTF setTextFieldLeftPaddingForWidth:16];
    [self.passwordTF setTextFieldLeftPaddingForWidth:16];
    [self.againPasswordTF setTextFieldLeftPaddingForWidth:16];
    [self.verificationCodeTF setTextFieldLeftPaddingForWidth:16];

    
    /// 获取短信验证码按钮
    [self setLayerWithView:self.getSMSCodeBtn];
    NSString *btnTitle = @"获取验证码";
    [self.getSMSCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.getSMSCodeBtn setTitle:btnTitle forState:UIControlStateNormal];
    [self.getSMSCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    __weak RegisterViewController *weakself = self;
    [self.getSMSCodeBtn addTouchedBlock:^(YHSMSCodeButton *sender) {
        //发送请求
        if (!weakself.phoneTF.text.length) {
            [weakself.view showWeakPromptViewWithMessage:@"手机号码不能为空"];
        }
        NSDictionary *dic = @{@"c":@"user",@"m":@"sendvcode",@"mobile":[APPHelper safeString:weakself.phoneTF.text]};
        [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=user&m=sendvcode" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            RegisterModel *model = [[RegisterModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
            [weakself.view showWeakPromptViewWithMessage:model.msg];
            
            //TODO:发送成功的时候 要不要显示验证码
            if (model.code.intValue == RequestResultStateSuccess)
            {
                weakself.verificationCodeTF.text = model.vcode;
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        sender.userInteractionEnabled = NO;
        [sender startWithSecond:60];
        /// 获取过程（倒计时）
        [sender didchangedBlock:^NSString *(YHSMSCodeButton *sender, int second) {
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            return nil;
        }];
        /// 倒计时结束 重置。
        [sender didFinishedBlock:^NSString *(YHSMSCodeButton *sender, int second) {
            sender.userInteractionEnabled = YES;
            [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            return btnTitle;
        }];
    }];
    
    [self addGestureWithTarget:self action:@selector(backKeyboard)];
    
    /// 给 textField 设置代理，按 return 键取消键盘
    self.passwordTF.delegate = self;
    self.againPasswordTF.delegate = self;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollView enableAvoidKeyboard];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scrollView disableAvoidKeyboard];
}


- (void)initSubViews
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.phoneTF];
    [self.scrollView addSubview:self.passwordTF];
    [self.scrollView addSubview:self.againPasswordTF];
    [self.scrollView addSubview:self.verificationCodeTF];
    [self.scrollView addSubview:self.getSMSCodeBtn];
    [self.scrollView addSubview:self.registerButton];
    [self.scrollView addSubview:self.protocalBtn];
    
    CGRect totalRect = self.view.bounds;
    totalRect.origin.y = kStatusBarHeight + kNavigationBarHeight + kLineWidth;
    [self.scrollView setFrame:totalRect];
    
    CGRect subRect = totalRect;
    //用户名
    subRect.origin.x = kDispaceToLeft;
    subRect.origin.y = 16;
    subRect.size.width = CGRectGetWidth(totalRect) - 2 * 16;
    subRect.size.height = 48;
    self.phoneTF.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.phoneTF.frame) + kDispaceToButtons;
    self.passwordTF.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.passwordTF.frame) + kDispaceToButtons;
    self.againPasswordTF.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.againPasswordTF.frame) + kDispaceToButtons;
    subRect.size.width = 170;
    self.verificationCodeTF.frame = subRect;
    
    subRect.origin.x = CGRectGetMaxX(self.verificationCodeTF.frame) + 16;
    subRect.size.width = CGRectGetWidth(self.phoneTF.frame) - 16 - CGRectGetWidth(self.verificationCodeTF.frame);
    self.getSMSCodeBtn.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.getSMSCodeBtn.frame) + 16;
    subRect.size.width = CGRectGetWidth(self.phoneTF.frame);
    subRect.size.height = 50;
    subRect.origin.x = kDispaceToLeft;

    self.registerButton.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.registerButton.frame) + 30;
    subRect.size.height = 16;
    self.protocalBtn.frame = subRect;
    
//    
//    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.view.mas_leading).offset(16);
//        make.trailing.equalTo(self.view.mas_trailing).offset(-16);
//        make.top.equalTo(self.view.mas_top).offset(80);
//        make.height.equalTo(@(48));
//    }];
//    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.view.mas_leading).offset(16);
//        make.trailing.equalTo(self.view.mas_trailing).offset(-16);
//        make.top.equalTo(self.phoneTF.mas_bottom).offset(8);
//        make.height.equalTo(@(48));
//    }];
//    [self.againPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.view.mas_leading).offset(16);
//        make.trailing.equalTo(self.view.mas_trailing).offset(-16);
//        make.top.equalTo(self.passwordTF.mas_bottom).offset(8);
//        make.height.equalTo(@(48));
//    }];
//    [self.verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.view.mas_leading).offset(16);
//        make.top.equalTo(self.againPasswordTF.mas_bottom).offset(8);
//        make.width.equalTo(@(170));
//        make.height.equalTo(@(48));
//    }];
//    [self.getSMSCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.verificationCodeTF.mas_trailing).offset(16);
//        make.trailing.equalTo(self.view.mas_trailing).offset(-16);
//        make.top.equalTo(self.againPasswordTF.mas_bottom).offset(8);
//        make.height.equalTo(@(48));
//    }];
//    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.view.mas_leading).offset(16);
//        make.trailing.equalTo(self.view.mas_trailing).offset(-16);
//        make.top.equalTo(self.verificationCodeTF.mas_bottom).offset(16);
//        make.height.equalTo(@(50));
//    }];
//    [self.protocalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.registerButton.mas_bottom).offset(25);
//        make.centerX.equalTo(self.view.mas_centerX);
//    }];
//    [self.protocalBtn setBackgroundColor:[UIColor redColor]];
//
    
}

#pragma mark - init views
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UITextField *)phoneTF
{
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.backgroundColor = [UIColor whiteColor];
        _phoneTF.placeholder = @"请输入手机号码";
        _phoneTF.font = [UIFont systemFontOfSize:16];
    }
    return _phoneTF;
}

-(UITextField *)passwordTF
{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.secureTextEntry = YES;
        _passwordTF.backgroundColor = [UIColor whiteColor];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.font = [UIFont systemFontOfSize:16];
    }
    return _passwordTF;
}

-(UITextField *)againPasswordTF
{
    if (!_againPasswordTF) {
        _againPasswordTF = [[UITextField alloc] init];
        _againPasswordTF.secureTextEntry = YES;
        _againPasswordTF.backgroundColor = [UIColor whiteColor];
        _againPasswordTF.placeholder = @"请重复密码";
        _againPasswordTF.font = [UIFont systemFontOfSize:16];
    }
    return _againPasswordTF;
}

-(UITextField *)verificationCodeTF
{
    if (!_verificationCodeTF) {
        _verificationCodeTF = [[UITextField alloc] init];
        _verificationCodeTF.backgroundColor = [UIColor whiteColor];
        _verificationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _verificationCodeTF.placeholder = @"请输入验证码";
        _verificationCodeTF.font = [UIFont systemFontOfSize:16];
    }
    return _verificationCodeTF;
}

-(YHSMSCodeButton *)getSMSCodeBtn
{
    if (!_getSMSCodeBtn) {
        _getSMSCodeBtn = [[YHSMSCodeButton alloc] init];
        _getSMSCodeBtn.backgroundColor = [UIColor whiteColor];
    }
    return _getSMSCodeBtn;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setLayerWithView:_registerButton];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:RGBACOLOR(234, 85, 6, 1.0f)];
        [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_registerButton addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

-(UIButton *)protocalBtn
{
    if (!_protocalBtn) {
        _protocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocalBtn setTitle:@"点击查看《用户协议》" forState:UIControlStateNormal];
        _protocalBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_protocalBtn setTitleColor:RGBACOLOR(74, 74, 74, 1.0f) forState:UIControlStateNormal];
        [_protocalBtn setBackgroundColor:[UIColor clearColor]];
        [_protocalBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    return _protocalBtn;
}

#pragma mark - click events
/// 注册
- (void)registerBtnClick:(UIButton *)sender
{
    //判断输入的手机号码 是否正确
    //判断是否为空
    if (!self.phoneTF.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"手机号码不能为空"];
        return;
    }
    else if (!self.passwordTF.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"密码不能为空"];
        return;
    }
    else if (![self.passwordTF.text isEqualToString:self.againPasswordTF.text])
    {
        [self.view showWeakPromptViewWithMessage:@"密码和重复密码不一致"];
        return;
    }
    else if (!self.verificationCodeTF.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"验证码不能为空"];
        return;
    }
    if (![JudgeTextIsRight isMobileNumber:self.phoneTF.text])
    {
        [self.view showWeakPromptViewWithMessage:@"用户名为不正确的手机号码"];
        return;
    }
    //开始注册
    NSDictionary *dic = @{/*@"c":@"user",@"m":@"register",*/@"mobile":[APPHelper safeString:self.phoneTF.text],@"yzm":[APPHelper safeString:self.verificationCodeTF.text],@"password":[APPHelper safeString:self.passwordTF.text]};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=user&m=register" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        RegisterModel *registerModel = [[RegisterModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
        [self.view showWeakPromptViewWithMessage:registerModel.msg];
        
        if (registerModel.code.intValue == RequestResultStateSuccess)
        {
            //这里要做特殊的处理
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view showWeakPromptViewWithMessage:@"注册失败"];

    }];
    
    
}

- (void)dismissRegisterVCAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - common utils
/// 设置 containerView 的 layer 样式
- (void)setLayerWithView:(UIView *)view
{
    view.layer.cornerRadius = 5;
    view.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
    view.layer.borderWidth = 0.5f;
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - scrollviewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

@end
