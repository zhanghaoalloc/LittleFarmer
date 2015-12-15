//
//  MyModel.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject

/*将字典中得数据解析到model中去*/

- (id)initContentWithDic:(NSDictionary *)jsonDic;

/*
 当model中得属性名与字典中得key不一致可以通过复写此方法来修正
 */
- (void)setAttributes:(NSDictionary *)jsonDic;

- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic;




@end
