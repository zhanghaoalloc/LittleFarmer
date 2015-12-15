//
//  MyAskQuestionModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@protocol MyAskQuestionList @end
@interface MyAskQuestionList : JSONModel

@property (nonatomic, copy) NSString<Optional> *listId;
@property (nonatomic, copy) NSString<Optional> *wtms;
@property (nonatomic, copy) NSString<Optional> *twsj;
@property (nonatomic, copy) NSString<Optional> *userid;
@property (nonatomic, copy) NSString<Optional> *xm;
@property (nonatomic, copy) NSString<Optional> *mobile;
@property (nonatomic, copy) NSString<Optional> *hdcs;
@property (nonatomic, copy) NSString<Optional> *zfcs;
//回答次数
@property (nonatomic, copy) NSString<Optional> *fxcs;
@property (nonatomic, copy) NSString<Optional> *usertx;
@property (nonatomic, copy) NSString<Optional> *location;
@property (nonatomic, copy) NSArray<Optional> *images;

@property (nonatomic, copy) NSString<Optional> *cellHeigth;


@end

@interface MyAskQuestionModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *count;
@property (nonatomic, copy) NSString<Optional> *pageSize;
@property (nonatomic, copy) NSArray<Optional,MyAskQuestionList> *list;



@end
