//
//  LeJSONUtil.h
//  WhatsLive
//
//  Created by letv-lic on 15/7/1.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeJSONUtil : NSObject

+ (NSString *)JSONString:(id)object;

+ (id)JSONObjectWith:(NSData *)data;

@end
