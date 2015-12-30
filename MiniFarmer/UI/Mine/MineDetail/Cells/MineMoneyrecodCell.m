//
//  MineMoneyrecodCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineMoneyrecodCell.h"

@implementation MineMoneyrecodCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _Content.font = [UIFont systemFontOfSize:17];
    _Content.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _time.font = kTextFont14;
    _time.textColor = [UIColor colorWithHexString:@"#666666"];
    
   
    [_count setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    _count.textColor = [UIColor colorWithHexString:@"#333333"];
}
- (void)setModel:(MineMoneymodel *)model{
    
    _model = model;
    _Content.text = _model.intro;
    _time.text = _model.datetime;
    
    NSString *value = _model.value;
    if ([value integerValue]>0) {
        _count.text =[NSString stringWithFormat:@"+%@",value];
    }else{
        _count.text = value;
    
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
