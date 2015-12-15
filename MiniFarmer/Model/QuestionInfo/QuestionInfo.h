//
//  QuestionInfo.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@interface QuestionInfo : JSONModel

@property (nonatomic,strong) NSString<Optional> *qid;
@property (nonatomic,strong) NSString<Optional> *wtms;
@property (nonatomic,strong) NSString<Optional> *twsj;
@property (nonatomic,strong) NSString<Optional> *userid;
@property (nonatomic,strong) NSString<Optional> *xm;
@property (nonatomic,strong) NSString<Optional> *mobile;
@property (nonatomic,strong) NSString<Optional> *hdcs;
@property (nonatomic,strong) NSString<Optional> *zfcs;
@property (nonatomic,strong) NSString<Optional> *fxcs;
@property (nonatomic,strong) NSString<Optional> *iscn;
@property (nonatomic,strong) NSString<Optional> *usertx;
@property (nonatomic,strong) NSString<Optional> *location;
@property (nonatomic,strong) NSString<Optional> *zwmc;
@property (nonatomic,strong) NSArray<NSString*> *images;
@property (nonatomic,strong) NSNumber <Optional>*iscoll;

@end
