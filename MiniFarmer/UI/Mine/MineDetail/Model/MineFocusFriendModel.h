//
//  MineFocusFriendModel.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseModel.h"



@protocol MineFocusFriendList
@end

@interface MineFocusFriendList : JSONModel

@property (nonatomic, copy) NSString<Optional> *listId;
@property (nonatomic, copy) NSString<Optional> *xm;
@property (nonatomic, copy) NSString<Optional> *zjlxms;
@property (nonatomic, copy) NSString<Optional> *sczwms;
@property (nonatomic, copy) NSString<Optional> *userid;
@property (nonatomic, copy) NSString<Optional> *usertx;
@property (nonatomic, copy) NSString<Optional> *grade;

@end


@interface MineFocusFriendModel : BaseModel


@property (nonatomic, strong) NSNumber<Optional> *count;
@property (nonatomic, strong) NSArray<Optional,MineFocusFriendList> *list;


@end
