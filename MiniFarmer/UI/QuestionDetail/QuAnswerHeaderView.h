//
//  QuAnswerHeaderView.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/23.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionAnsModel.h"

@interface QuAnswerHeaderView : UITableViewHeaderFooterView<UIAlertViewDelegate>

- (void)refreshWithAnsModel:(QuestionAnsModel *)ansModel;
+ (CGFloat)headerHeightWithAnsModel:(QuestionAnsModel *)ansModel;

@property(nonatomic,assign)BOOL isSelf;//判断是否是自己提出来的问题
@property(nonatomic,assign)BOOL isAdopt;//判断该回答是否被采纳
@property(nonatomic,assign)BOOL isQuesCn;//判断这个问题是否被采纳





@end
