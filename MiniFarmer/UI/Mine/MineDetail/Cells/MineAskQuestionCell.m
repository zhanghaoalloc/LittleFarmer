//
//  MineReponseCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/19.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineAskQuestionCell.h"
#import "MyAskQuestionModel.h"

@interface MineAskQuestionCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;

@end

@implementation MineAskQuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setHiddenLine:YES];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomLineHeight.constant = kLineWidth;
    self.lineHeight.constant = kLineWidth;
    
}

- (void)refreshDataWithModel:(id)model
{
    MyAskQuestionList *list = (MyAskQuestionList *)model;
//    self.contentLabel.text = @"最近发现家里的葡萄叶子都黄了，刚长出来的果实也蔫了，不知道是什么情况，有专家能帮我看看吗？非常急，先谢谢，！";
//    [self.contentLabel setTextLineSpace:8 font:kTextFont(16)];
//    self.messageLabel.text = @"20";
//    self.timeLabel.text = @"20天前";
    self.contentLabel.text = list.wtms;
    self.messageLabel.text = list.hdcs;
    self.timeLabel.text = [APPHelper describeTimeWithMSec:list.twsj];
    
    
    

}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    //距离顶部的高度 + 内容的高度 + 14 + 时间的高度 + 20 + klinwidth
    MyAskQuestionList *list = (MyAskQuestionList *)model;
    if (!list.cellHeigth || list.cellHeigth.intValue == 0)
    {
        CGSize textSize = [APPHelper getStringWordWrappingSize:list.wtms andConstrainToSize:CGSizeMake(kScreenSizeWidth - 24, CGFLOAT_MAX) andFont:kTextFont(16)];
        list.cellHeigth = [NSString stringWithFormat:@"%f",textSize.height];
    }
    
    
    return 12 + list.cellHeigth.floatValue + 14 + 16 + 20 + kLineWidth;
}


@end
