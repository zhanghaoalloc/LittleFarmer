//
//  QuestionCellSource.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionCellSource.h"

@interface QuestionCellSource()

@property (nonatomic,assign)CGSize contentLabelSize;
@property (nonatomic,assign)CGFloat cellTotalHeight;
@property (nonatomic,assign)CGFloat nameLabelWidth;
@property (nonatomic,assign)CGFloat locationLabelWidth;

@end

@implementation QuestionCellSource

- (instancetype)initWithQuestionInfo:(QuestionInfo *)info
{
    self = [super init];
    if (self) {
        self.qInfo = info;
    }
    return self;
}

- (void)setQInfo:(QuestionInfo *)qInfo
{
    if (qInfo == _qInfo) {
        return;
    }
    
    _qInfo = qInfo;
    
    self.contentLabelSize = [APPHelper getStringWordWrappingSize:_qInfo.wtms andConstrainToSize:CGSizeMake(kMaxContentWidth, kMaxContentLabelHeight) andFont:kTextFont16];
    
    self.nameLabelWidth = [APPHelper getStringWordWrappingSize:_qInfo.xm andConstrainToSize:CGSizeMake(80, kBottemViewHeight) andFont:kTextFont14].width;
    
    self.locationLabelWidth = [APPHelper getStringWordWrappingSize:_qInfo.location andConstrainToSize:CGSizeMake(120, kBottemViewHeight) andFont:kTextFont12].width;
    
    self.cellTotalHeight = kOutputViewTopPadding + kContentTopPadding+ _contentLabelSize.height + kMiddleViewTopPadding + kMiddleViewHeight + kBottemViewHeight;
    if (_qInfo.images.count > 0)
    {
        self.cellTotalHeight += kPicViewTopPadding + kPicImgHeight;
    }
}

@end
