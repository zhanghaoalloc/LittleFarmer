//
//  SingleImgCollectionViewCell.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SingleImgCollectionViewCell.h"

@interface SingleImgCollectionViewCell()

@property (nonatomic,strong)UIImageView *picView;
@end

@implementation SingleImgCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picView = [UIImageView new];
        [self.contentView addSubview:_picView];
        [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark- public
- (void)refreshWithImageUrl:(NSString *)url

{
    
    [_picView sd_setImageWithURL:[NSURL URLWithString:[APPHelper safeString:url]] placeholderImage:nil];
}

@end
