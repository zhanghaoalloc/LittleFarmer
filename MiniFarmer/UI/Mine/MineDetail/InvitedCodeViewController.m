//
//  InvitedCodeViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "InvitedCodeViewController.h"
#import "UILabel+CustomAttributeLabel.h"
#import "InvitedCode.h"

@interface InvitedCodeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *invitedCodeScrollview;
@property (strong, nonatomic) IBOutlet UITextField *invitedTF;
@property (strong, nonatomic) IBOutlet UIButton *invitedBT;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *invitedLineHeight;

@property (strong, nonatomic) IBOutlet UIImageView *invitedLine;
@property (strong, nonatomic) IBOutlet UIButton *wathInvitedBT;
@property (strong, nonatomic) IBOutlet UILabel *wathInvitedLabel;
@property (strong, nonatomic) IBOutlet UIButton *howUseInvitedCodeBT;
@property (strong, nonatomic) IBOutlet UILabel *howUseInvitedCodeLaebl;
@property (strong, nonatomic) IBOutlet UIButton *whyUseInvitedCodeBT;

@property (strong, nonatomic) IBOutlet UILabel *whyUseInvitedCodeLabel;




@end

@implementation InvitedCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarTitle:@"填写邀请码"];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [self configureSubviews];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.invitedCodeScrollview.contentSize = CGSizeMake(kScreenSizeWidth, CGRectGetMaxY(self.whyUseInvitedCodeLabel.frame) + kBottomTabBarHeight);
}

#pragma mark - subviews

- (void)configureSubviews
{
#define kBTTitleColor [UIColor colorWithHexString:@"333333"]
#define kLabelColor [UIColor colorWithHexString:@"666666"]
#define kLineDispace 8
    self.invitedTF.textColor = [UIColor colorWithHexString:@"a3a3a3"];
    [self.invitedBT setBackgroundColor:RGBCOLOR(17, 132, 255)];
    self.invitedBT.layer.cornerRadius = 7;
    [self.invitedLine setBackgroundColor:[UIColor colorWithHexString:@"dddddd"]];
    self.invitedLineHeight.constant = kLineWidth;
    [self.wathInvitedBT setTitleColor:kBTTitleColor forState:UIControlStateNormal];
    [self.howUseInvitedCodeBT setTitleColor:kBTTitleColor forState:UIControlStateNormal];
    [self.whyUseInvitedCodeBT setTitleColor:kBTTitleColor forState:UIControlStateNormal];
    [self.wathInvitedLabel setTextColor:kLabelColor];
    [self.howUseInvitedCodeLaebl setTextColor:kLabelColor];
    [self.whyUseInvitedCodeLabel setTextColor:kLabelColor];
    [self.wathInvitedLabel setTextLineSpace:kLineDispace font:kTextFont(16)];
    [self.howUseInvitedCodeLaebl setTextLineSpace:kLineDispace font:kTextFont(16)];
    [self.whyUseInvitedCodeLabel setTextLineSpace:kLineDispace font:kTextFont(16)];

    UIImage *foucsImage =[UIImage imageNamed:@"mine_btn_foucs_nm"];
    UIImage *inveitedFriendImage = [UIImage imageNamed:@"mine_btn_invited_nm"];
    NSArray *arr = @[@"点击 “",foucsImage,@"发现” 中的 “",inveitedFriendImage,@"邀请好友”，即可分享邀请码给好友。"];
    [self.howUseInvitedCodeLaebl attributeLabelWithArray:arr];
}




#pragma mark - click
- (IBAction)tapInvitedBT:(id)sender
{
    if (!self.invitedTF.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"邀请码不能为空"];
        return;
    }
    
    NSDictionary *dic = @{@"userid":[[MiniAppEngine shareMiniAppEngine] userId],@"username":[[MiniAppEngine shareMiniAppEngine] userLoginNumber],@"icode":self.invitedTF.text};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"?c=user&m=save_vicode" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        InvitedCode *invitedCode = [[InvitedCode alloc] initWithDictionary:responseObject error:nil];
        if (invitedCode.code.intValue == RequestResultStateSuccess)
        {
            [self.view showWeakPromptViewWithMessage:invitedCode.msg];
            [self.navigationController popViewControllerAnimated:YES];

        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view showWeakPromptViewWithMessage:@"请求失败，请检查网络"];

    }];
    
}

#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


@end
