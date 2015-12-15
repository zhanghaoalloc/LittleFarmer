//
//  QuAnswerReplyCell.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuAnswerReplyCell.h"

#define kContentLeftSpace      50
#define kContentRightSpace     20
#define kTopPadding     10
#define kBottomPadding  10

@interface QuAnswerReplyCell()
{
    UILabel     *_replyContentLabel;
    ReplyModel  *_replyModel;  
}
@end

@implementation QuAnswerReplyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{  
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        //回复Label
        _replyContentLabel = [UILabel new];
        [self.contentView addSubview:_replyContentLabel];
        //_replyContentLabel.backgroundColor = [UIColor greenColor];
        _replyContentLabel.numberOfLines = 0;
        _replyContentLabel.font = kTextFont14;
        _replyContentLabel.textColor = kTextBlackColor;
        
        
        [self addViewConstraints];
    }
    return self;
}

- (void)refreshWithReplyModel:(ReplyModel *)model
{
    _replyModel = model;

        NSString *content = [NSString stringWithFormat:@"%@：%@",model.username,model.replaytext];
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc]initWithString:content];
        
        NSUInteger nameLength = model.username.length;
        
        [message addAttribute:NSForegroundColorAttributeName value:kLightBlueColor range:NSMakeRange(0, nameLength)];
        [message addAttribute:NSForegroundColorAttributeName value:kTextBlackColor range:NSMakeRange(nameLength, message.length-nameLength)];
        _replyContentLabel.attributedText = message;

    
}

+ (CGSize)contentSizeWithReplyModel:(ReplyModel *)model
{
    NSString *content = [NSString stringWithFormat:@"%@：%@",model.username,model.replaytext];
    CGSize contentSize = [APPHelper getStringWordWrappingSize:content andConstrainToSize:CGSizeMake(kScreenSizeWidth-kContentLeftSpace-kContentRightSpace, 20000) andFont:kTextFont14];
    return contentSize;
}

+ (CGFloat)cellTotalHightWithReplyModel:(ReplyModel *)model
{
    CGSize contentSize = [[self class] contentSizeWithReplyModel:model];
    return contentSize.height +kTopPadding +kBottomPadding;
}

#pragma mark- private
- (void)addViewConstraints
{
    [_replyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kTopPadding);
        make.left.equalTo(self.contentView).offset(kContentLeftSpace);
        make.right.equalTo(self.contentView).offset(-kContentRightSpace);
        make.bottom.equalTo(self.contentView).offset(-kBottomPadding);
    }];
}

@end
