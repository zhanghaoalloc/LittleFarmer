//
//  MyAnswerCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionInfo.h"
#import "QuestionCellSource.h"


@interface MyAnswerCell : UITableViewCell

@property(nonatomic,strong)QuestionCellSource *qSource;

- (void)refreshWithQuestionCellSource:(QuestionCellSource *)source;





@end
