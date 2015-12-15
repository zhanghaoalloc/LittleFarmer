//
//  LeJSONUtil.m
//  WhatsLive
//
//  Created by letv-lic on 15/7/1.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import "LeJSONUtil.h"

@implementation LeJSONUtil

+ (NSString *)JSONString:(id)object
{
    if (![NSJSONSerialization isValidJSONObject:object]){
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!error && [jsonData length] > 0){
        __autoreleasing NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

+ (id)JSONObjectWith:(NSData *)data;
{
    NSError *error = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (!error){
        return obj;
    }else{
        return nil;
    }
    return obj;
}

@end
