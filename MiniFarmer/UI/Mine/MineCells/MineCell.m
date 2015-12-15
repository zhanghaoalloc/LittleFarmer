//
//  MineCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineCell.h"
#import "UserMenuItem.h"

@interface MineCell ()

@property (nonatomic, strong) UIImageView *mineImageView;
@property (nonatomic, strong) UILabel *mineLabel;

@end

@implementation MineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.mineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.mineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.mineLabel.font = kTextFont(16);
        self.mineLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:self.mineImageView];
        [self.contentView addSubview:self.mineLabel];
        
        [self.mineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        
        [self.mineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.mineImageView.mas_right).offset(14);
            
        }];
        
    }
    return self;
}


- (void)refreshDataWithModel:(id)model
{
    UserMenuItem *item = (UserMenuItem *)model;
    self.mineImageView.image = [UIImage imageNamed:item.imageString];
    self.mineLabel.text = item.title;
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 44;
}




@end
