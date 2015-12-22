//
//  MineSaveTechnology.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseModel.h"

@protocol MineSaveTechnologyList @end
@interface MineSaveTechnologyList : JSONModel

@property (nonatomic, copy)NSString<Optional> *listId;
@property (nonatomic, copy)NSString<Optional> *title;
@property (nonatomic, copy)NSString<Optional> *fbwh;
@property (nonatomic, copy)NSString<Optional> *lbzp;
@property (nonatomic, copy)NSString<Optional> *bigclassid;
@property (nonatomic, copy)NSString<Optional> *bigclassname;
@property (nonatomic, copy)NSString<Optional> *twoclassid;
@property (nonatomic, copy)NSString<Optional> *twoclassname;


@end



@interface MineSaveTechnology : BaseModel

@property (nonatomic, strong) NSArray<Optional,MineSaveTechnologyList> *list;

@end

