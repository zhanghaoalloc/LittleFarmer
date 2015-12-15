//
//  DrugDetailView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/30.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DrugDetailView.h"
#import "UIView+FrameCategory.h"

@implementation DrugDetailView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];
    }
    return self;

}
- (void)_createSubView{
    
    //调整视图的位置
    
    CGFloat weigth = (kScreenSizeWidth -100 -48)/2;
    //左边的图片
    _leftimageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 19,weigth ,2 )];
    [_leftimageV setImage:[UIImage imageNamed:@"home_study_drug"]];
    [self addSubview:_leftimageV];
    
    _recommend = [[UILabel alloc] initWithFrame:CGRectMake(_leftimageV.right+12, 10, 100, 20)];
    _recommend.text = @"相关药品推荐";
    _recommend.textAlignment = NSTextAlignmentCenter;
    _recommend.textColor = [UIColor colorWithHexString:@"#333333"];
    _recommend.font = kTextFont16;
    [self addSubview:_recommend];

    
  

    _imageView = [[UIImageView alloc] initWithFrame: CGRectMake(_recommend.right+12, 19, weigth, 2)];
    _imageView.transform = CGAffineTransformMakeRotation(M_PI);
    [_imageView setImage:[UIImage imageNamed:@"home_study_drug"]];
    [self addSubview:_imageView];
    
        self.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];



}




@end
