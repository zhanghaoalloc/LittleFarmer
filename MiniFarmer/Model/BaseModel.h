//
//  BaseModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

typedef enum
{
    RequestResultStateFaild,
    RequestResultStateSuccess
}RequestResultState;

@interface BaseModel : JSONModel

@property (nonatomic, strong) NSNumber <Optional> *code;
@property (nonatomic, copy) NSString <Optional> *msg;

@end
