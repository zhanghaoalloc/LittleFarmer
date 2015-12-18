//
//  BusinessCardCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BusinessCardCell.h"

@implementation BusinessCardCell

- (void)awakeFromNib {
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
    _model = model;
    
    _invite.text = _model.icode;
    _age.text = _model.zjnl;
    _location.text = _model.location;
    _good.text = _model.sczwms;
    _introduce.text = _model.zzzw;

}
- (void)setExpermodel:(ExpertModel *)expermodel{
    _expermodel = expermodel;
    _introduce.text = _expermodel.zjjs;


}


@end
