//
//  AnswerInputView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AnswerInputView.h"
#import "SHHttpClient.h"
#import "UserInfo.h"
#import "UIViewAdditions.h"

#define ktextViewplaceholder @"回复"

@implementation AnswerInputView

- (void)awakeFromNib{
    
    _topline.backgroundColor = [UIColor colorWithHexString:@"#a3a3a3"];
    //高度自适应
    _textView.layer.borderColor = [[UIColor colorWithHexString:@"#cbcbcb"] CGColor];
    _textView.layer.borderWidth = 0.5f;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textView.textColor = [UIColor colorWithHexString:@"333333"];
    _textView.font = kTextFont(14);
    _textView.placeholderColor = [UIColor colorWithHexString:@"#a3a3a3"];
    _textView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
     _textView.layer.cornerRadius = 16;
    _textView.delegate = self;
    
    
    
    [_send setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_no_enable_nm"] forState:UIControlStateDisabled];
    [_send setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_hl"] forState:UIControlStateHighlighted];
    [_send setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_enable_nm"] forState:UIControlStateNormal];
    [_send setTitle:@"发送" forState:UIControlStateNormal];
    _send.titleLabel.font = [UIFont systemFontOfSize:13];
    [_send setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_send setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_send setEnabled:NO];
    [_send addTarget:self action:@selector(sendAsk:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)sendAsk:(UIButton *)button{
    
    NSString *textStreing = [_textView.placeholder stringByAppendingString:_textView.text];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString *userid =[UserInfo shareUserInfo].userId;
    
    NSString *username = [UserInfo shareUserInfo].userName;
    
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:username forKey:@"username"];
    [dic setObject:textStreing forKey:@"replytext"];
    
    //model为回答问题的model,所包含的信息为为回答问题者的信息
    //replymodel的为回复问题的model，

    if (_replymodel == nil) {
        [dic setObject:_model.usertx forKey:@"usertx"];
        [dic setObject:_model.ansid forKey:@"hfid"];
        [dic setObject:_model.userid forKey:@"rruserid"];
        [dic setObject:_model.xm forKey:@"rrusername"];
    }else{
        if (_replymodel.usertx == nil) {
            _replymodel.usertx = @"0";
        }
    
        [dic setObject:_replymodel.usertx forKey:@"usertx"];
        
        [dic setObject:_replymodel.hf_id  forKey:@"hfid"];
        [dic setObject:_replymodel.user_id forKey:@"rruserid"];
        [dic setObject:_replymodel.rr_userid forKey:@"rruserid"];
        [dic setObject:_replymodel.rr_name forKey:@"rrusername"];
        
        
    }
    
    
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"?c=tw&m=savetwhf_re" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.viewController.view showWeakPromptViewWithMessage:@"回复成功"];
        [self.viewController.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)changeSendButtonStateToEnable:(BOOL)enable
{
    [self.send setEnabled:enable];
}
#pragma mark ---UITextView代理
//文本开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]))
    {
        [self changeSendButtonStateToEnable:NO];
    }
    
}
//文本已经改变
- (void)textViewDidChange:(UITextView *)textView
{
    if ((textView.text.length
         || ![textView.text isEqualToString:@""])
        && !self.send.enabled)
    {
        [self changeSendButtonStateToEnable:YES];
    }
    
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]) && self.send.enabled)
    {
        [self changeSendButtonStateToEnable:NO];
    }
}
//文本完成编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]))
    {
        [self changeSendButtonStateToEnable:NO];
    }
}
- (void)setUsername:(NSString *)username{
    
    }

- (void)setReplymodel:(ReplyModel *)replymodel{
    _replymodel = replymodel;
    if (_replymodel == nil) {
       
        NSString *str = [NSString stringWithFormat:@"回复%@", self.model.xm];
        _textView.placeholder = str;

        
    }else{
        NSString *str = [NSString stringWithFormat:@"回复%@",_replymodel.username];
        _textView.placeholder = str;
    
    }
   

}



@end
