//
//  LoginViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/1.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseViewController+Navigation.h"
#import "RegisterViewController.h"
#import "LoginModel.h"
#import "ResetPasswordViewController.h"

#define kLoginDispaceToLeft 16

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *usernameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *seletedButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UILabel *label;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    
    [self setNavigationBarIsHidden:YES];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(dismissAction)];
    [self setBarRightDefaultButtonWithTarget:self action:@selector(registAction)];
    [self setBarTitle:@"用户登录"];
    [self initSubviews];
    
    /// 给 self.view 添加手势，取消键盘
    [self addGestureWithTarget:self action:@selector(backKeyboard)];
    
    /// 给 textField 设置代理，按 return 键取消键盘
    self.passwordTF.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([JudgeTextIsRight isMobileNumber:self.usernameTF.text])
    {
        [[MiniAppEngine shareMiniAppEngine] saveUserLoginNumber:self.usernameTF.text];
    }
    [[MiniAppEngine shareMiniAppEngine] saveInfos];
}

/// 初始化子视图
- (void)initSubviews
{
    [self.view addSubview:self.usernameTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginButton];
    
    [self.view addSubview:self.seletedButton];
    [self.view addSubview:self.label];
    [self.view addSubview:self.forgetButton];
    
    [self setLayerWithView:self.usernameTF];
    [self setLayerWithView:self.passwordTF];
    [self setLayerWithView:self.loginButton];

    [self.usernameTF setTextFieldLeftPaddingForWidth:16];
    [self.passwordTF setTextFieldLeftPaddingForWidth:16];

    [self configSubviewsValue];
    
    CGRect subRect;
    subRect.origin.x = kLoginDispaceToLeft;
    subRect.origin.y = kStatusBarHeight + kNavigationBarHeight + 16;
    subRect.size.width = CGRectGetWidth(self.view.frame) - 2 * kLoginDispaceToLeft;
    subRect.size.height = 48;
    self.usernameTF.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.usernameTF.frame) + 8;
    self.passwordTF.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.passwordTF.frame) + 20;
    subRect.size.height = 50;
    self.loginButton.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.loginButton.frame) + 16;
    subRect.origin.x = CGRectGetMaxX(self.loginButton.frame) - 88;
    subRect.size.width = 78;
    subRect.size.height = 20;
    self.forgetButton.frame = subRect;
    
    
    subRect.origin.x = kLoginDispaceToLeft  + 10;
    subRect.size.width = 21;
    subRect.size.height = 21;
    self.seletedButton.frame = subRect;
    
    subRect.origin.x = CGRectGetMaxX(self.seletedButton.frame) + 24;
    subRect.size.width = 80;
    subRect.size.height = 20;
    self.label.frame = subRect;
    
    
}

#pragma mark - click events
/// 登录
- (void)loginBtnClick:(UIButton *)sendr
{
    //键盘回收
    [self backKeyboard];
    
    //判断用户名和密码是否为空
    DLOG(@"---- %@",self.usernameTF.text);
    if (!self.usernameTF.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"账号不能为空"];
        return;
    }
    else if (!self.passwordTF.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"密码不能为空"];
        return;
    }
    
    //请求登录的接口
    NSDictionary *dic = @{/*@"c":@"user",@"m":@"userlogin",*/@"mobile":[APPHelper safeString:self.usernameTF.text],@"password":[APPHelper safeString:self.passwordTF.text]};
    [self.view showLoadingWihtText:@"登录中"];
    __weak __typeof(self)weakSelf = self;
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost
                                             subUrl:@"?c=user&m=userlogin"
                                         parameters:dic
                                     prepareExecute:nil
                                            success:^(NSURLSessionDataTask *task, id responseObject)
    {
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        [self.view dismissLoading];
        LoginModel *loginModel = [[LoginModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
        
        if ([loginModel.msg isEqualToString:@"success"]
            && loginModel.code.intValue == RequestResultStateSuccess)
        {
            //登陆成功保存电话号码 保存用户userid
            [[MiniAppEngine shareMiniAppEngine] saveUserId:loginModel.rows.userId];
            [[MiniAppEngine shareMiniAppEngine] saveUserLoginNumber:self.usernameTF.text];
            [[MiniAppEngine shareMiniAppEngine] saveLogin];
            [[MiniAppEngine shareMiniAppEngine] saveInfos];
            strongSelf.loginBackBlock();
            
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
            
        }
        else
        {
            [strongSelf.view showWeakPromptViewWithMessage:loginModel.msg];
        }
        
        
        NSLog(@"sdfasdf");
            
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        [strongSelf.view dismissLoading];
        [strongSelf.view showWeakPromptViewWithMessage:@"登录失败"];

    }];
}

/// 忘记密码
- (void)forgetPasswordBtnClick:(UIButton *)sender
{
    [self backKeyboard];
    ResetPasswordViewController *resetVC = [[ResetPasswordViewController alloc] init];
    [self.navigationController pushViewController:resetVC animated:YES];
    
}

/// 记住账号
- (void)remberNumber:(UIButton *)sender
{
    [self backKeyboard];
    
    sender.selected = !sender.selected;
    [[MiniAppEngine shareMiniAppEngine] setSaveNumber:sender.selected];
}

/// 取消登录
- (void)dismissAction
{
    [self backKeyboard];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//注册按钮
- (void)registAction
{
    [self backKeyboard];
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark -load views

-(UITextField *)usernameTF
{
    if (!_usernameTF)
    {
        _usernameTF = [[UITextField alloc] init];
        _usernameTF.backgroundColor = [UIColor whiteColor];
        _usernameTF.font = [UIFont systemFontOfSize:16];
        _usernameTF.placeholder = @"请输入手机号码";
        _usernameTF.keyboardType = UIKeyboardTypeNumberPad;
        _usernameTF.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
        _usernameTF.layer.borderWidth = kLineWidth;
        
    }
    return _usernameTF;
}

-(UITextField *)passwordTF
{
    if (!_passwordTF)
    {
        _passwordTF = [[UITextField alloc] init];;
        _passwordTF.backgroundColor = [UIColor whiteColor];
        _passwordTF.font = [UIFont systemFontOfSize:16];
        _passwordTF.secureTextEntry = YES;
        _passwordTF.placeholder = @"请输入密码";
        UIView *horldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 48)];
        _passwordTF.leftView = horldView;
        _passwordTF.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
        _passwordTF.layer.borderWidth = 0.5f;
    }
    return _passwordTF;
}

-(UIButton *)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = RGBACOLOR(234, 85, 6, 1.0f);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginButton addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UIButton *)seletedButton
{
    if (!_seletedButton)
    {
        _seletedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seletedButton setImage:[UIImage imageNamed:@"login_btn_unselected"] forState:UIControlStateNormal];
        [_seletedButton setImage:[UIImage imageNamed:@"login_btn_selected"] forState:UIControlStateSelected];
        [_seletedButton addTarget:self action:@selector(remberNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seletedButton;
}

-(UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        _label.text = @"记住账号";
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _label;
}

-(UIButton *)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(forgetPasswordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

#pragma mark - common



/// 取消键盘
- (void)backKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - configSubviewsValue
- (void)configSubviewsValue
{
    if ([[MiniAppEngine shareMiniAppEngine] isHasSaveUserLoginNumber])
    {
        self.usernameTF.text = [[MiniAppEngine shareMiniAppEngine] userLoginNumber];
        self.seletedButton.selected = YES;
    }
}

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


@end
