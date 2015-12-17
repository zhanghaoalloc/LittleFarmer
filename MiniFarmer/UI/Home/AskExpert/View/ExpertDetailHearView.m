//
//  ExpertDetailHearView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ExpertDetailHearView.h"

@implementation ExpertDetailHearView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _createSubView];
    }
    return self;
}
- (void)_createSubView{
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _title = [UILabel new];
    _title.font =kTextFont14;
    _title.textAlignment = NSTextAlignmentLeft;
    _title.textColor = [UIColor colorWithHexString:@"#333333"];
    [self addSubview:_title];
    [self addmas];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
     [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@0.5);
    }];
   

}
//添加约束
- (void)addmas{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.top.equalTo(self).offset(12);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).offset(12);
        make.top.equalTo(self).offset(12);
        make.right.equalTo(self).offset(12);
    }];
    
}
- (void)setImageString:(NSString *)imageString{
    _imageString = imageString;


    [_imageView setImage:[UIImage imageNamed:_imageString]];
   
}
- (void)setTitleString:(NSString *)titleString{
    
    _titleString = titleString;
    _title.text = _titleString;


}





@end
