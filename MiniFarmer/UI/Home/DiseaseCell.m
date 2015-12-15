//
//  DiseaseCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DiseaseCell.h"

@implementation DiseaseCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _titleLabel.font = kTextFont16;
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _commentLabel.font = kTextFont16;
    _commentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    

}

- (CGFloat)countHeigthForLabel:(UILabel *)label Labelwidth:(CGFloat )witdh LineSpacing:(CGFloat)spacing{
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0,[label.text length])];
    [label setAttributedText:attributedString];
    [label sizeToFit];
    
    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGSize size = CGSizeMake(witdh, 2000);
    
    CGSize labsize = [label.text sizeWithFont:kTextFont16 constrainedToSize:size lineBreakMode:label.lineBreakMode];
    CGFloat texetheigth= labsize.height;
    
    CGFloat linespaceHeigth = labsize.height/20*10;
    
    CGFloat  heigth = texetheigth+linespaceHeigth;
    
    
    return heigth;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}
- (void)setComment:(NSString *)comment{
   _comment  = comment;
   _commentLabel.text = _comment;
    CGFloat textheigth = [self countHeigthForLabel:_commentLabel Labelwidth:kScreenSizeWidth-32 LineSpacing:8];
    
   // self.heigth = textheigth+52;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
