//
//  MineFocusFriendCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineFocusFriendCell.h"

@interface MineFocusFriendCell ()

@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;


@end

@implementation MineFocusFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.photoButton.layer.cornerRadius = 31;
        [self.photoButton addTarget:self action:@selector(tapPhotoBT:) forControlEvents:UIControlEventTouchUpInside];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.nameLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        [self.nameLabel setFont:kTextFont(16)];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.contentLabel setFont:kTextFont(14)];
        
        [self.contentView addSubview:self.photoButton];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        
        
        [self.photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.size.mas_equalTo(CGSizeMake(62, 62));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.photoButton.mas_right).offset(14);
            make.top.equalTo(self.contentView.mas_top).offset(24);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        
    }
    return self;
}

- (void)tapPhotoBT:(UIButton *)btn
{
    
}


- (void)refreshDataWithModel:(id)model
{
    //TODO:这里需要修改 因为list中的model 不知道 这里是仿照专家 写的 
    MineFocusFriendList *list = (MineFocusFriendList *)model;
    [self.photoButton sd_setImageWithURL:[NSURL URLWithString:list.usertx] forState:UIControlStateNormal placeholderImage:nil];
    [self.nameLabel setText:list.xm];
//    self.nameLabel.text = ;
    self.contentLabel.text = list.sczwms;
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 86 + kLineWidth;
}


@end
