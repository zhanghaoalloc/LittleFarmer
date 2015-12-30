//
//  BusinessCardCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BusinessCardCell.h"

@implementation BusinessCardCell
+ (CGFloat)countTotalHeigth:(ExpertModel *)heigthModel{
    
    UILabel *label = [UILabel new];
    label.font = kTextFont14;
    label.text = heigthModel.zjjs;

    CGFloat heigth=[self countHeigthForLabel:label Labelwidth:kScreenSizeWidth-24-70 LineSpacing:6];
        
    CGFloat totalHeigth = heigth + 152;
        
    return  totalHeigth;

}

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _invite.font = kTextFont14;
    _invite.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _age.font = kTextFont14;
    _age.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _location.font = kTextFont14;
    _location.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _good.font = kTextFont14;
    _good.textColor = [UIColor colorWithHexString:@"#333333"];
    
    
    _introduce.font = kTextFont14;
    _introduce.textColor = [UIColor colorWithHexString:@"#333333"];
    

}

- (void)setModel:(ExpertDetailModel *)model{
    //第一组的专家名片
    _model = model;
    
    _invite.text = _model.icode;
    _age.text = _model.zjnl;
    _location.text = _model.location;
    _good.text = _model.sczwms;
   
    

}
- (void)setExpermodel:(ExpertModel *)expermodel{
    
    if (self.model ==nil) {
      //  _invite.text = _expermodel.icode;
        _age.text = _expermodel.zjnl;
        _location.text = _expermodel.location;
        _good.text = _expermodel.sczwms;
       
        

        
    }
    _expermodel = expermodel;
    _introduce.text = _expermodel.zjjs;
    
    [self countHeigthForLabel:_introduce Labelwidth:kScreenSizeWidth-24-70 LineSpacing:6];
   

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


+ (CGFloat)countHeigthForLabel:(UILabel *)label Labelwidth:(CGFloat )witdh LineSpacing:(CGFloat)spacing{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[APPHelper safeString:label.text]];
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

@end
