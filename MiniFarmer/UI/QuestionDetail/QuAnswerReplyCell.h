//
//  QuAnswerReplyCell.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionAnsModel.h"

@interface QuAnswerReplyCell : UITableViewCell

- (void)refreshWithReplyModel:(ReplyModel *)model;

+ (CGFloat)cellTotalHightWithReplyModel:(ReplyModel *)model;
@end
