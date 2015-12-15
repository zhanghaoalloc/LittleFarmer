//
//  StudyHeaderView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "StudyHeaderView.h"
#import "UIView+FrameCategory.h"
#import "UILabel+CustomAttributeLabel.h"
#import "PhotoViewController.h"
#import "UIViewAdditions.h"

@implementation StudyHeaderView
- (void)awakeFromNib{
    _backgroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_backgroundView addGestureRecognizer:tap];
    
    
    [_countView setImage:[UIImage imageNamed:@"home_study_count"]];
    
    _countLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _countLabel.font = kTextFont16;
    
    
    self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    _DiseaseName.textColor = [UIColor colorWithHexString:@"#333333"];
    _DiseaseName.font = kTextFont18;
    
    
    _diseasedetail.font = kTextFont16;
    _diseasedetail.textColor = [UIColor colorWithHexString:@"#333333"];
    

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
    CGFloat linespaceHeigth = (texetheigth/20)*(spacing+5);
    CGFloat  heigth = texetheigth+linespaceHeigth;
    return heigth;
}
- (void)setModel:(DieaseModel *)model{
    _model = model;
    NSInteger i = _model.images.count;
    if (i == 0) {
        i = 1;
    }
    _countLabel.text =[NSString stringWithFormat:@"%ld",i];
    _DiseaseName.text = _model.title;
    
    
  
    
    
    NSString *url = _model.zp1;
    NSString *str = [kPictureURL stringByAppendingString:url];
    NSURL *URL = [NSURL URLWithString:str];
    [_backgroundView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"Sys_defalut"]];
    
    _diseasedetail.text = _model.fbwh;
    CGFloat heigth =[self countHeigthForLabel:_diseasedetail Labelwidth:kScreenSizeWidth-32 LineSpacing:10];
    self.height = heigth+350;
    _countView.contentMode = UIViewContentModeScaleAspectFit;

}
- (void)setImages:(NSMutableArray *)images{
    _images = images;
    NSInteger i =0 ;
    for (NSString *str in _images) {
        if (str.length == 0) {
            i++;
        }
    }
    NSInteger s = images.count -i;
    _countLabel.text  = [NSString stringWithFormat:@"%ld",s];
    


}
- (void)tap{
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    photoVC.imageUrls = _images;
    
    [self.viewController.navigationController pushViewController:photoVC animated:YES];


}




@end
