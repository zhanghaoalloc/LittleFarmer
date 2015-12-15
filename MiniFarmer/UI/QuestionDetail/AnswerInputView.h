//
//  AnswerInputView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"
#import "QuestionAnsModel.h"


@interface AnswerInputView : UIView <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *textView;


@property (weak, nonatomic) IBOutlet UIButton *send;
@property (weak, nonatomic) IBOutlet UIView *topline;

@property(nonatomic,strong)ReplyModel *replymodel;
@property(nonatomic,strong)QuestionAnsModel *model;









@end
