//
//  MyRecipeModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@protocol MyRecipeList @end
@interface MyRecipeList : JSONModel
@property (nonatomic, copy) NSString<Optional> *xm;
@property (nonatomic, copy) NSString<Optional> *usertx;
@property (nonatomic, copy) NSString<Optional> *zjid;
@property (nonatomic, copy) NSString<Optional> *location;
@property (nonatomic, copy) NSString<Optional> *listId;
@property (nonatomic, copy) NSString<Optional> *pfmc;
@property (nonatomic, copy) NSString<Optional> *tag;
@property (nonatomic, copy) NSString<Optional> *pfscsj;
@property (nonatomic, copy) NSString<Optional> *bigclassid;
@property (nonatomic, copy) NSString<Optional> *bigclasssname;
@property (nonatomic, copy) NSString<Optional> *twoclassid;
@property (nonatomic, copy) NSString<Optional> *twoclassname;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *pfms;
@property (nonatomic, copy) NSString<Optional> *ddcs;
@property (nonatomic, copy) NSString<Optional> *commentcs;
@property (nonatomic, copy) NSString<Optional> *imgcolumns;
@property (nonatomic, copy) NSArray<Optional> *images;
@property (nonatomic, copy) NSString<Optional> *msg;





@end

@interface MyRecipeModel : JSONModel
@property (nonatomic, strong) NSNumber<Optional> *code;
@property (nonatomic, copy) NSString<Optional> *msg;
@property (nonatomic, strong) NSNumber<Optional> *count;
@property (nonatomic, strong) NSArray<Optional,MyRecipeList> *list;

@end
