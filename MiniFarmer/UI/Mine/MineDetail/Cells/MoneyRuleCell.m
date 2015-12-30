//
//  MoneyRuleCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MoneyRuleCell.h"

@implementation MoneyRuleCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _number.font = kTextFont14;
    _number.textColor = [UIColor colorWithString:@"#666666"];
    
    _content.font =kTextFont14;
    _content.textColor =[UIColor colorWithString:@"#333333"];
    _content.numberOfLines = 0;
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    NSString *str = [dic objectForKey:@"number" ];
    
    _number.text =[NSString stringWithFormat:@"%@.",str];
    _content.text = [dic objectForKey:@"content"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
