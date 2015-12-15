//
//  QuCommonView.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionInfo.h"

@interface QuCommonView : UIView

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign,readonly)CGFloat totalViewHeight;

- (void)refreshWithQuestionInfo:(QuestionInfo *)info;
@end
