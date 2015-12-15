//
//  MyReponseModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/19.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseModel.h"

@protocol List @end
@interface List : JSONModel

@property (nonatomic, copy) NSString<Optional> *listId;
///问题的描述
@property (nonatomic, copy) NSString<Optional> *wtms;
@property (nonatomic, copy) NSString<Optional> *userid;
@property (nonatomic, copy) NSString<Optional> *xm;
@property (nonatomic, copy) NSString<Optional> *mobile;
@property (nonatomic, copy) NSString<Optional> *hdcs;
@property (nonatomic, copy) NSString<Optional> *zfcs;
@property (nonatomic, strong) NSArray<Optional> *images;

@end



@interface MyReponseModel : BaseModel


@property (nonatomic, copy) NSNumber<Optional> *device;
@property (nonatomic, copy) NSNumber<Optional> *count;


@property (nonatomic, copy) NSArray<Optional,List> *list;

@end
