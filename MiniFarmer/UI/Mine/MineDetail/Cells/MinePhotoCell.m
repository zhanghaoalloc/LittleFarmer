
//
//  MinePhotoCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MinePhotoCell.h"
#import "UserMenuItem.h"

@interface MinePhotoCell ()

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *photoBT;

@end

@implementation MinePhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.titleLabel setFont:kTextFont(16)];
        [self.titleLabel setTextColor:[UIColor colorWithHexString:@"666666"]];
        
        self.photoBT = [UIButton buttonWithType:UIButtonTypeCustom];
        self.photoBT.layer.cornerRadius = 22;
        self.photoBT.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.photoBT];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.photoBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-24);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        
    }
    return self;
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 74;
}

- (void)refreshDataWithModel:(id)model
{
    UserMenuItem *item = (UserMenuItem *)model;
    
    self.titleLabel.text = item.title;
    //头像
    NSString *iconimage = item.imageString;
    
    NSURL *iconURL;
    
    if ([iconimage rangeOfString:@"http://www.enbs.com.cn"].location!= NSNotFound) {
        //有前缀
        
        iconURL = [NSURL URLWithString:[APPHelper safeString:iconimage]];
        
    }else{
        NSString *str = [kPictureURL stringByAppendingString:iconimage];
        iconURL =[NSURL URLWithString:[APPHelper safeString:str]];
    }

    [self.photoBT sd_setImageWithURL:iconURL forState:UIControlStateNormal placeholderImage:nil];
}

@end
