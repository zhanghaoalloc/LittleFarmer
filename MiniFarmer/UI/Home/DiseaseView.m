//
//  DiseaseView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DiseaseView.h"
#import "UIImageView+WebCache.h"
#import "DiseaDetailViewController.h"
#import "UIView+UIViewController.h"

@implementation DiseaseView{

    NSString *_bchid;

}
- (void)awakeFromNib{
    
    _name.font = kTextFont14;
    _name.textColor = [UIColor colorWithHexString:@"#666666"];
    
    _count.font = kTextFont(11);
    _count.textColor = [UIColor colorWithHexString:@"#ffffff"];
    
   

    
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_imageView addGestureRecognizer:tap];

    
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    _name.text =_dic[@"title"];
    
    NSString *url =_dic[@"lbzp"];
    
    _bchid = _dic[@"id"];

    NSString *str = [kPictureURL stringByAppendingString:url];
    
    NSURL *URL = [NSURL URLWithString:str];
    
    
    [_imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"Sys_defalut"]];
     [_browseV setImage:[UIImage imageNamed:@"home_study_detail_browse"]];
    
   // [_imageView setImageWithURL:url];
}
- (void)setModel:(TwoclassMode *)model{
    _model = model;
    if (_model== nil) {
        self.hidden = YES;
    }
    _name.text = _model.title;
    _bchid = _model.diseaid;

    
    NSString *url =_model.lbzp;
    
    NSString *str = [kPictureURL stringByAppendingString:url];
    
    NSURL *URL = [NSURL URLWithString:str];
    
    
    [_imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"Sys_defalut"]];
     [_browseV setImage:[UIImage imageNamed:@"home_study_detail_browse"]];
    
}
- (void)tap{
    
    DiseaDetailViewController *detailVC = [[DiseaDetailViewController alloc] init];
    
    detailVC.bchid = _bchid;
    [self.ViewController.navigationController pushViewController:detailVC animated:YES];


}

@end
