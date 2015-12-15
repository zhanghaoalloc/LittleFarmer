//
//  QuestionAnsModel.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/15.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@protocol ReplyModel <NSObject>

@end

@interface ReplyModel : JSONModel

@property (nonatomic,strong)NSString<Optional> *ansid;
@property (nonatomic,strong)NSString<Optional> *hf_id;
@property (nonatomic,strong)NSString<Optional> *rr_id;
@property (nonatomic,strong)NSString<Optional> *rr_userid;
@property (nonatomic,strong)NSString<Optional> *replaytext;
@property (nonatomic,strong)NSString<Optional> *username;
@property (nonatomic,strong)NSString<Optional> *user_id;
@property (nonatomic,strong)NSString<Optional> *usertx;
@property (nonatomic,strong)NSString<Optional> *location;
@property (nonatomic,strong)NSString<Optional> *rr_name;
@end

@interface QuestionAnsModel : JSONModel

@property (nonatomic,strong)NSString<Optional> *ansid;
@property (nonatomic,strong)NSString<Optional> *wtid;
@property (nonatomic,strong)NSString<Optional> *hdnr;
@property (nonatomic,strong)NSString<Optional> *zjid;
@property (nonatomic,strong)NSString<Optional> *fdzp;
@property (nonatomic,strong)NSString<Optional> *hdsj;
@property (nonatomic,strong)NSString<Optional> *userid;
@property (nonatomic,strong)NSString<Optional> *mobile;
@property (nonatomic,strong)NSString<Optional> *xm;
@property (nonatomic,strong)NSString<Optional> *usertx;
@property (nonatomic,strong)NSString<Optional> *location;
@property (nonatomic,assign)NSString<Optional> *dzcs;
@property (nonatomic,assign)NSNumber<Optional> *isdz;
@property (nonatomic,assign)NSNumber<Optional> *iscoll;
@property (nonatomic,assign)NSNumber<Optional> *iscn;
@property (nonatomic,strong)NSString<Optional> *zjlxms;
@property (nonatomic,strong)NSString<Optional> *grade;
@property (nonatomic,strong)NSArray<ReplyModel> *relist;
@end

