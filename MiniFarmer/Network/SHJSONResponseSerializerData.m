//
//  SHJSONResponseSerializerData.m
//  baby
//
//  Created by lic on 15/1/8.
//  Copyright (c) 2015年 lic. All rights reserved.
//

#import "SHJSONResponseSerializerData.h"

@implementation SHJSONResponseSerializerData

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (*error != nil) {
            NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
            userInfo[@"JSONResponseSerializerWithDataKey"] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
            (*error) = newError;
        }
        
        return (nil);
    }
    
    return ([super responseObjectForResponse:response data:data error:error]);
}

@end
