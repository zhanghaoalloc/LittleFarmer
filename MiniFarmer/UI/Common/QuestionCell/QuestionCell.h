//
//  QuestionCell.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionInfo.h"
#import "QuestionCellSource.h"

@interface QuestionCell : UITableViewCell

- (void)refreshWithQuestionCellSource:(QuestionCellSource *)source;

@end
