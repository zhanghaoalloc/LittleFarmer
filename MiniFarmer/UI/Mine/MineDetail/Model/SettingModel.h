//
//  SettingModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@interface SettingModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, strong)NSNumber<Optional> *heigth;
@property (nonatomic, copy) NSString<Optional> *classString;
@end
