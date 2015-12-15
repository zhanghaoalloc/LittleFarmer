//
//  QuestionDetailModel.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"
#import "QuestionInfo.h"

@interface QuestionDetailModel : JSONModel

@property (nonatomic,retain)QuestionInfo<Optional> *wt;
@end
