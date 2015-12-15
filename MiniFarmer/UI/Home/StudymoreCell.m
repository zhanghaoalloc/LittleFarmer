//
//  StudymoreCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "StudymoreCell.h"

@implementation StudymoreCell

- (void)awakeFromNib {
    
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    self.selected = NO;

    name.font = kTextFont16;
    name.textColor = [UIColor colorWithHexString:@"#333333"];
    
    more.font = kTextFont14;
    more.textColor = [UIColor colorWithHexString:@"#3872f4"];
    
   
    
}
- (void)setModel:(StudyModel *)model{
    _model = model;
    name.text = model.twoclassname;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
