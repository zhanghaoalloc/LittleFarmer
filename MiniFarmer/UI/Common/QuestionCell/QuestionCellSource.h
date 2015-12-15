//
//  QuestionCellSource.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionInfo.h"


#define kLeftSpace              12
#define kRightSpace             12
#define kOutputViewTopPadding   10
#define kContentTopPadding      12
#define kMaxContentWidth        (kScreenSizeWidth-kLeftSpace-kRightSpace)
#define kMaxContentLabelHeight  20000
#define kMiddleViewHeight       26
#define kMiddleViewTopPadding   5
#define kPicPadding             3
#define kPicImgWidth            ((kMaxContentWidth-2*kPicPadding)/3.0)
#define kPicImgHeight           (kPicImgWidth/1.1)
#define kPicViewTopPadding      12
#define kBottemViewHeight       36

@interface QuestionCellSource : NSObject

@property (nonatomic,retain)QuestionInfo *qInfo;
@property (nonatomic,assign,readonly)CGSize contentLabelSize;
@property (nonatomic,assign,readonly)CGFloat cellTotalHeight;
@property (nonatomic,assign,readonly)CGFloat nameLabelWidth;
@property (nonatomic,assign,readonly)CGFloat locationLabelWidth;

- (instancetype)initWithQuestionInfo:(QuestionInfo *)info;
@end
