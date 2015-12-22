//
//  DetailView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

- (void)awakeFromNib{
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#dddddd"]);
    
    _tx.layer.cornerRadius = 16;
    _tx.layer.masksToBounds = YES;
    
    _xm.textColor = [UIColor colorWithHexString:@"#666666"];
    _location.textColor = [UIColor colorWithHexString:@"#999999"];
    _time.textColor = [UIColor colorWithHexString:@"#999999"];
    

}

- (void)setModel:(MethodDetailModel *)model{
    
    _model = model;
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kPictureURL,_model.usertx]];
    
    _tx.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                 
    _xm.text = _model.xm;
    _location.text = _model.location;
    _time.text = _model.pfscsj;
    _ddcs.text = _model.ddcs;
    
    _pfms.text = _model.pfms;
    
    if (_model.images.count == 1) {
        
        _img1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.firstObject]]];
    }
    
    if (_model.images.count == 2) {
        
        _img1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.firstObject]]];
        _img2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.lastObject]]];
    }
    
    if (_model.images.count == 3) {
        _img1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.firstObject]]];
        _img2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_model.images objectAtIndex:1]]]];
        _img3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.lastObject]]];
    }
    
    CGSize pfmssize = [APPHelper getStringWordWrappingSize:_model.pfms andConstrainToSize:CGSizeMake(kScreenSizeWidth - 24, 1000) andFont:[UIFont systemFontOfSize:17]];
    
    if (_model.images.count == 0) {
        
        _height = 19+25+16 + pfmssize.height + 16;
    }
    
    else{
        
        _height = 19+25+16 + pfmssize.height + 91.5 + 28;
    }

    
}


@end
