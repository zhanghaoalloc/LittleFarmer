//
//  SearchNotFindView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SearchNotFindView.h"

@implementation SearchNotFindView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];
    }
    return self;


}
- (void)_createSubView{
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [imgV setImage:[UIImage imageNamed:@"home_search_notfind"]];
    [self addSubview:imgV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,150, 40)];
    label.numberOfLines= 2;
    label.text = @"没有找到相关内容请试试其他关键词";
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.font = kTextFont18;
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo (@150);
       // make.height.equalTo(@40);
    }];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(label.mas_top).offset(-12);
        make.width.equalTo(@109.5);
        make.height.equalTo(@135);
    }];
    
}

@end
