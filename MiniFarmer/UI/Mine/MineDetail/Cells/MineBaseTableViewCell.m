//
//  MineBaseTableViewCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseTableViewCell.h"
#import "SettingModel.h"
#define kDidpaceToSide 0
@interface MineBaseTableViewCell ()



@end

@implementation MineBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.line = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.line setBackgroundColor:[UIColor colorWithHexString:@"e4e4e4"]];
        [self.contentView addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(kDidpaceToSide);
            make.right.equalTo(self.contentView.mas_right).offset(-kDidpaceToSide);
            make.top.equalTo(self.contentView.mas_bottom).offset(-kLineWidth);
            make.height.equalTo(@(kLineWidth));
            
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setHiddenLine:(BOOL)hidden
{
    [self.line setHidden:hidden];
}

- (void)refreshDataWithModel:(id)model
{
    
}
+ (CGFloat)cellHeightWihtModel:(id)model
{
    SettingModel *settingModel = (SettingModel *)model;
    return settingModel.heigth.floatValue;
}


@end
