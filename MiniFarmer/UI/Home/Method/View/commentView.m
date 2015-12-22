//
//  commentView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/11.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "commentView.h"

@implementation commentView

- (void)awakeFromNib{

    
    _commenttext.layer.borderWidth = 0.5;
    _commenttext.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#cbcbcb"]);
    
    _commenttext.placeholder = @"  说点什么";
    _commenttext.font = [UIFont systemFontOfSize:14];
    _commenttext.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _commenttext.textColor = [UIColor colorWithHexString:@"#333333"];
    
    [_sendBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [_sendBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateSelected];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
    

}
@end
