//
//  RecomentViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "RecomentViewController.h"
#import "GCPlaceholderTextView.h"
#import "UIScrollView+LGKeyboard.h"

#define kCornerRadius 5

@interface RecomentViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong)GCPlaceholderTextView *recommentTextView;
@property (nonatomic, strong)UITextField *phoneTextField;
@property (nonatomic, strong)UIButton *submitBT;
@property (nonatomic, strong)UIScrollView *recomentScrollview;


@end

@implementation RecomentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarTitle:@"意见反馈"];
    [self addSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [self.recomentScrollview enableAvoidKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.recomentScrollview disableAvoidKeyboard];
}

#pragma mark - subviews

- (void)addSubviews
{
    [self.view addSubview:self.recomentScrollview];
    [self.recomentScrollview addSubview:self.recommentTextView];
    [self.recomentScrollview addSubview:self.phoneTextField];
    [self.recomentScrollview addSubview:self.submitBT];
    
    CGRect subRect = self.view.bounds;
    subRect.origin.y = self.yDispaceToTop;
    subRect.size.height = kScreenSizeHeight - self.yDispaceToTop;
    self.recomentScrollview.frame = subRect;
    
    subRect.origin.y = 16;
    subRect.origin.x = 12;
    subRect.size = CGSizeMake(kScreenSizeWidth - 2 * 12, 186);
    self.recommentTextView.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.recommentTextView.frame) + 16;
    subRect.size.height = 40;
    self.phoneTextField.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.phoneTextField.frame) + 20;
    subRect.size.height = 44;
    self.submitBT.frame = subRect;
    
    
}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField)
    {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneTextField.placeholder = @"请输入11位手机号码 (必填)";
        _phoneTextField.layer.cornerRadius = kCornerRadius;
        _phoneTextField.layer.borderWidth = kLineWidth;
        _phoneTextField.font = kTextFont(16);
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        [_phoneTextField setTextFieldLeftPaddingForWidth:16];
        _phoneTextField.delegate = self;
        _phoneTextField.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
    }
    return _phoneTextField;
}

- (GCPlaceholderTextView *)recommentTextView
{
    if (!_recommentTextView)
    {
        _recommentTextView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
        _recommentTextView.textColor = [UIColor colorWithHexString:@"a3a3a3"];
        _recommentTextView.font = kTextFont(16);
        _recommentTextView.placeholderColor = _recommentTextView.textColor;
        _recommentTextView.delegate = self;
        _recommentTextView.layer.cornerRadius = kCornerRadius;
        _recommentTextView.layer.borderWidth = kLineWidth;
        _recommentTextView.backgroundColor = [UIColor whiteColor];
        _recommentTextView.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _recommentTextView.placeholder = @"请至少输入10个字符的意见反馈";
        
    }
    return _recommentTextView;
}

- (UIButton *)submitBT
{
    if (!_submitBT) {
        _submitBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBT setTitle:@"提 交" forState:UIControlStateNormal];
        [_submitBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBT.titleLabel setFont:kTextFont(18)];
        _submitBT.layer.cornerRadius = kCornerRadius;
        _submitBT.backgroundColor = RGBCOLOR(17, 132, 255);
        [_submitBT addTarget:self action:@selector(tapSubmitBT:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitBT;
}

- (UIScrollView *)recomentScrollview
{
    if (!_recomentScrollview)
    {
        _recomentScrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _recomentScrollview.showsHorizontalScrollIndicator = NO;
        _recomentScrollview.showsVerticalScrollIndicator = NO;
        
    }
    return _recomentScrollview;
}

#pragma mark - clickEvents

- (void)tapSubmitBT:(UIButton *)btn
{
    //点击提交
    if (self.recommentTextView.text.length < 10) {
        [self.view showWeakPromptViewWithMessage:@"请填入最少10个字符的意见哦"];
         return;
    }
    else if (!self.phoneTextField.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"手机号码不能为空"];
        return;
  
    }
    else if (![JudgeTextIsRight isMobileNumber:self.phoneTextField.text])
    {
        [self.view showWeakPromptViewWithMessage:@"请输入正确的手机号"];
         return;
    }
    //发送请求
    NSDictionary *dic = @{@"userid":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userId]],@"mobile":[APPHelper safeString:self.phoneTextField.text],@"prolemtext":[APPHelper safeString:self.recommentTextView.text]};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"?c=set&m=save_problem" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        BaseModel *model = [[BaseModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
        if (model.code.intValue == RequestResultStateSuccess)
        {
            [self.view showWeakPromptViewWithMessage:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        [self.view showWeakPromptViewWithMessage:@"提交失败"];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view showWeakPromptViewWithMessage:@"提交失败"];

    }];
}

#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *bValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [bValue getValue:&animationDuration];
    
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:keyboardRect fromView:[[UIApplication sharedApplication] keyWindow]];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    DLOG(@"##keboardHeight=%.2f",keyboardHeight);
    
    self.recomentScrollview.contentSize = CGSizeMake(self.recomentScrollview.frame.size.width, CGRectGetHeight(self.recomentScrollview.frame) + keyboardHeight);
    
    
}

- (void)keyBoardWillHidden:(NSNotification *)notification
{
    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *bValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [bValue getValue:&animationDuration];
    
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:keyboardRect fromView:[[UIApplication sharedApplication] keyWindow]];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    DLOG(@"##keboardHeight will hidden=%.2f",keyboardHeight);
    self.recomentScrollview.contentSize = CGSizeMake(self.recomentScrollview.frame.size.width, CGRectGetHeight(self.recomentScrollview.frame));

}


@end
