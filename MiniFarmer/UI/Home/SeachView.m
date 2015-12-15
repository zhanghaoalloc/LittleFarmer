//
//  SeachView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SeachView.h"
#import "UIView+UIViewController.h"
#import "MessageViewController.h"
#import "SearchViewController.h"
#import "UITextField+CustomTextField.h"


@implementation SeachView{
    UITextField  *_textfiled;

}
- (void)awakeFromNib{
    _textView.layer.cornerRadius = 4;
    _textView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    _textfiled = (UITextField *)[_textView viewWithTag:201];
    _textfiled.delegate = self;
    [_textfiled setTextColor:[UIColor colorWithHexString:@"#a3a3a3"]];
    _textfiled.font = kTextFont(14);
    _textfiled.returnKeyType = UIReturnKeySearch;

    _message.titleLabel.font = kTextFont18;
    [_message setTitleColor:[UIColor colorWithHexString:@"#a3a3a3"] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
}
//文字按钮
- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title.length != 0) {
        [_message setTitle:_title forState:UIControlStateNormal];
        [_message addTarget:self action:@selector(textAction:) forControlEvents:UIControlEventTouchUpInside];
    }


}
//图片按钮
- (void)setImageNmae:(NSString *)imageNmae{
   _imageNmae = imageNmae;
    if (_imageNmae.length != 0) {
        [_message setImage:[UIImage imageNamed:_imageNmae] forState:UIControlStateNormal];
        [_message addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
        //[_message setImage:[UIImage imageNamed:@"home_btn_message_pinside"] forState:UIControlStateHighlighted];
    }
    
}
#pragma mark ----搜索栏按钮的点击事件
- (void)setIsSearch:(BOOL)isSearch{
    _isSearch = isSearch;
    if (_isSearch ==NO) {
        [_textfiled addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventTouchDown];
    }
    
}
- (void)textFieldAction:(UITextField *)textfiled{
   
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.index = _index;
    self.ViewController.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.ViewController.navigationController pushViewController:searchVC animated:YES];
    
    


}
- (void)textAction:(UIButton *)button{
    [self.ViewController.navigationController popViewControllerAnimated:YES];
}
- (void)imageAction:(UIButton *)button{
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    messageVC.view.backgroundColor = [UIColor whiteColor];
   
    self.ViewController.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self.ViewController.navigationController pushViewController:messageVC animated:YES];
    
    

}
#pragma mark ----UITextfiled的协议方法
//将要开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    

    return YES;

}
//监听发送按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    return YES;
}




@end
