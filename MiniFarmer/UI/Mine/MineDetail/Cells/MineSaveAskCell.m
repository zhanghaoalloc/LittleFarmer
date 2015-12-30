
//
//  MineSaveAskCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSaveAskCell.h"
#import "MineSaveTechnology.h"

@interface MineSaveAskCell ()

@property (nonatomic, strong) UIButton *photoBT;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation MineSaveAskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.photoBT = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self.nameLabel setFont:kTextFont(16)];
        [self.nameLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        
        [self.contentLabel setFont:kTextFont(14)];
        [self.contentLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.contentLabel setNumberOfLines:2];
        [self.contentView addSubview:self.photoBT];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        
        
        [self.photoBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(18);
            make.size.mas_equalTo(CGSizeMake(100, 75));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.photoBT.mas_right).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(18);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
        }];
    }
    return self;
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    
    return 100 + kLineWidth;
}

- (void)refreshDataWithModel:(id)model
{
    
    MineSaveTechnologyList *list = (MineSaveTechnologyList *)model;
    NSString *iconStr =list.lbzp;
    NSURL *iconURL;
    
    if ([iconStr rangeOfString:@"http://www.enbs.com.cn"].location!= NSNotFound) {
        //有前缀
        iconURL = [NSURL URLWithString:[APPHelper safeString:iconStr]];
        
    }else{
        NSString *str = [kPictureURL stringByAppendingString:iconStr];
        
        iconURL =[NSURL URLWithString:[APPHelper safeString:str]];
    }

    [self.photoBT sd_setImageWithURL:iconURL forState:
        UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Sys_defalut"]];
    
    self.nameLabel.text = list.title;
    
    /*CGSize labsize = [label.text sizeWithFont:kTextFont16 constrainedToSize:size lineBreakMode:label.lineBreakMode];*/
   
    
    
    
    self.contentLabel.text = list.fbwh;
    
}

@end
