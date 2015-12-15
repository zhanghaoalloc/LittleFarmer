//
//  ReplyViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"
#import "QuestionAnsModel.h"

@interface ReplyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>



@property(nonatomic,strong)QuestionAnsModel *model;
@property(nonatomic,strong)ReplyModel *replymodel;







@end
