//
//  SettingAbountCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SettingAbountCell.h"
#import "SettingAboutView.h"
#import "SettingModel.h"

@interface SettingAbountCell ()

@property (nonatomic, strong) SettingAboutView *abountView;
@property (nonatomic, strong) UIImageView *subLine;

@end

@implementation SettingAbountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.abountView = [[[NSBundle mainBundle] loadNibNamed:@"SettingAboutView" owner:self options:nil] lastObject];
        self.subLine = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.subLine setBackgroundColor:[UIColor colorWithHexString:@"e4e4e4"]];
        [self.contentView addSubview:self.abountView];
        [self.contentView addSubview:self.subLine];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.abountView.frame = self.contentView.bounds;
    self.subLine.frame = CGRectMake(self.lineDispaceToLeft, CGRectGetHeight(self.frame) - kLineWidth, CGRectGetWidth(self.frame) - self.lineDispaceToLeft, kLineWidth);
    self.subLine.backgroundColor = [UIColor colorWithHexString:self.stringColor];
}

- (void)refreshDataWithModel:(id)model
{
    [self.abountView reloadDataWithModel:model];
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    SettingModel *settingModel = (SettingModel *)model;
    return settingModel.heigth.floatValue + kLineWidth;
}
@end
