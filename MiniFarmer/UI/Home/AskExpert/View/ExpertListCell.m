//
//  ExpertListCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ExpertListCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"

@implementation ExpertListCell

- (void)awakeFromNib {
    //图像
    _icon.layer.cornerRadius = 32;
    _icon.layer.masksToBounds = YES;

    
    //名字
    _name.font = kTextFont16;
    _name.textColor = [UIColor colorWithHexString:@"#333333"];
    
    //类型
    _type.font = kTextFont14;
    _type.textColor = [UIColor colorWithHexString:@"#333333"];
    
    //擅长领域
    _good.font = kTextFont14;
    _good.textColor = [UIColor colorWithHexString:@"#999999"];
    
    //问题
    [_questionbutton setBackgroundImage:[UIImage imageNamed:@"home_expert_ask_btn"] forState:UIControlStateNormal];
    [_questionbutton setTitle:@"提交" forState:UIControlStateNormal];
    [_questionbutton setTitleColor:[UIColor colorWithHexString:@"488bff"] forState:UIControlStateNormal];
    [_questionbutton addTarget:self action:@selector(questionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)setModel:(ExpertModel *)model{
    _model = model;
    
    
    NSString *iconStr = _model.usertx;
    [_icon sd_setImageWithURL:[NSURL URLWithString:iconStr]];
   
    _name.text = _model.xm;
    _type.text = _model.zjlxms;
    _good.text = _model.sczwms;
    


}
- (void)questionAction:(UIButton *)button{
    
        
    
    
}


@end
