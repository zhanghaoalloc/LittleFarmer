//
//  MineSaveQuestionModel.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseModel.h"


@interface MineSaveQuestionModelList : JSONModel

@property (nonatomic, copy) NSString *listId;
@end

@interface MineSaveQuestionModel : BaseModel

@property (nonatomic, strong) NSArray *list;

@end
