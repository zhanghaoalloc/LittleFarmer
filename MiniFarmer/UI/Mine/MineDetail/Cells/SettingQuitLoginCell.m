//
//  SettingQuitLoginCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SettingQuitLoginCell.h"
#import "SettingModel.h"

@interface SettingQuitLoginCell ()
@property (nonatomic, strong) UIButton *quiltBT;
@end

@implementation SettingQuitLoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        self.quiltBT = [UIButton buttonWithType:UIButtonTypeCustom];
        self.quiltBT.backgroundColor = RGBCOLOR(17, 132, 255);
        [self.quiltBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.quiltBT.titleLabel setFont:[UIFont systemFontOfSize:18]];
        self.quiltBT.layer.cornerRadius = 7;
        [self.quiltBT addTarget:self action:@selector(tapQuilt:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.quiltBT];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.quiltBT.frame = CGRectMake(12, 0, CGRectGetWidth(self.frame) - 2 * 12, CGRectGetHeight(self.frame));
}

- (void)refreshDataWithModel:(id)model
{
    [self.quiltBT setTitle:[(SettingModel *)model title]forState:UIControlStateNormal];

}

- (void)tapQuilt:(UIButton *)btn
{
    self.tapQuilt(btn);
}



@end
