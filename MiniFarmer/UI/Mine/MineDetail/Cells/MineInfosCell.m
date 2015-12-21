//
//  MineInfosCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineInfosCell.h"
#import "UserMenuItem.h"

@interface MineInfosCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *guideImageView;


@end

@implementation MineInfosCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.font = kTextFont(16);
        self.nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLabel.font = kTextFont(16);
        self.contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        self.guideImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.guideImageView setImage:[UIImage imageNamed:@"mine_setting_btn_nm"]];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.guideImageView];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        
        [self.guideImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 14));
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(30);
            make.right.equalTo(self.guideImageView.mas_left).offset(-12);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        

    }
    return self;
}

- (void)refreshDataWithModel:(id)model
{
    UserMenuItem *item = (UserMenuItem *)model;
    self.nameLabel.text = item.title;
    self.contentLabel.text = item.subTitle;

}
- (void)setImageIshidden:(BOOL)imageIshidden{

    _imageIshidden = imageIshidden;
    
    self.guideImageView.hidden = _imageIshidden;

}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 44;
}

@end
