//
//  MineExpertModel.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseModel.h"

@protocol MineExpertList
@end

@interface MineExpertList : JSONModel

@property (nonatomic, copy) NSString<Optional> *listId;
@property (nonatomic, copy) NSString<Optional> *xm;
@property (nonatomic, copy) NSString<Optional> *zjlxms;
@property (nonatomic, copy) NSString<Optional> *sczwms;
@property (nonatomic, copy) NSString<Optional> *userid;
@property (nonatomic, copy) NSString<Optional> *usertx;
@property (nonatomic, copy) NSString<Optional> *grade;

@end


@interface MineExpertModel : BaseModel

@property (nonatomic, copy) NSNumber<Optional> *count;

@property (nonatomic, copy) NSArray<Optional,MineExpertList> *list;

@end
