//
//  AskSendModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/9.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@interface AskSendModel : BaseModel

@property (nonatomic, copy) NSString<Optional> *wtid;
@property (nonatomic, copy) NSString<Optional> *zjid;
@property (nonatomic, copy) NSString<Optional> *zjmobile;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSNumber<Optional> *uri;

@end
