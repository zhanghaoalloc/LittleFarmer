//
//  MethodViewCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/7.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MethodViewCell.h"

@implementation MethodViewCell


- (void)awakeFromNib {
    
    _bgView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _bgView.layer.borderWidth = 0.5;
    _bgView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#dddddd"]);
    
    _bgView.layer.cornerRadius = 4;
    
    _tx.layer.cornerRadius = 10;
    _tx.clipsToBounds = YES;

    
    _pfmc.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _xm.textColor = [UIColor colorWithHexString:@"#666666"];
    
    _location.textColor = [UIColor colorWithHexString:@"#999999"];

    _content.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _zjtj.textColor = [UIColor colorWithHexString:@"#ffffff"];
    

    _zjtj.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"expert-recommendation"]];

    
        //设置行距
    NSMutableParagraphStyle *pastyle = [[NSMutableParagraphStyle alloc] init];
    pastyle.lineSpacing = 8;
    
    
    _ddcs.textColor = [UIColor colorWithHexString:@"#999999"];
    
    _time.textColor = [UIColor colorWithHexString:@"#999999"];
        

}


- (void)setModel:(MethodModel *)model {
    
    _model = model;
    
    _pfmc.text = _model.pfmc;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kPictureURL,_model.usertx]];
    
    _tx.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    _xm.text = _model.xm;
    
    _location.text = _model.location;
    
    _content.text = _model.pfms;
    
    _time.text = _model.pfscsj;
    
    _ddcs.text = _model.ddcs;
    
    
    int a = [_model.imgcolumns intValue];
    
    if (a == 1) {
        
        _xiaotu1.hidden = YES;
        _xiaotu2.hidden = YES;
        _xiaotu3.hidden = YES;
        _datu.hidden = NO;
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kPictureURL,_model.images.lastObject]];


        
        _datu.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
       
       
    }else if (a == 3) {
        
        _datu.hidden = YES;
        _xiaotu1.hidden = NO;
        _xiaotu2.hidden = NO;
        _xiaotu3.hidden = NO;
        
        if (_model.images.count == 1) {
            
            _xiaotu1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.firstObject]]];
        }
        
        if (_model.images.count == 2) {
            
            _xiaotu1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.firstObject]]];
            _xiaotu3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.lastObject]]];
        }
        
        //  小图 2- 3 反了;

        if (_model.images.count == 3) {
             _xiaotu1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.firstObject]]];
            _xiaotu3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_model.images objectAtIndex:1]]]];
            _xiaotu2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.images.lastObject]]];
        }
        
    }
}


@end
