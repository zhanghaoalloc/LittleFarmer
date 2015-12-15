//
//  SHHttpClient.m
//  baby
//
//  Created by lic on 15/1/8.
//  Copyright (c) 2015年 lic. All rights reserved.
//

#import "SHHttpClient.h"
#import "SHJSONResponseSerializerData.h"
#import <netinet/in.h>
#import "LeJSONUtil.h"

@interface SHHttpClient()

@property(nonatomic,strong) AFHTTPSessionManager *manager;

@property(nonatomic,strong) AFHTTPRequestOperation* uploadOperation;

@end

@implementation SHHttpClient

- (id)init
{
    if (self = [super init]){
        self.manager = [AFHTTPSessionManager manager];

        //响应结果序列化类型
        self.manager.responseSerializer = [SHJSONResponseSerializerData serializer];//[AFImageResponseSerializer serializer];//[SHJSONResponseSerializerData serializer];

        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/javascript",@"text/html",@"image/gif", nil];
        
        [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
        
        _uploadOperation = nil;
    }
    return self;
}

+ (SHHttpClient *)defaultClient
{
    static SHHttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(SHHttpRequestType)method
             parameters:(id)parameters
         prepareExecute:(PrepareRequestBlock)prepareRequest
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    //请求的URL
    DLOG(@"Request path:=====%@",url);
    
    NSURLSessionDataTask* task = nil;
    
    NSMutableDictionary* parametersDic = nil;
    
    __block NSString* paramString = @"";
    
    if((parameters != nil )  && [parameters isKindOfClass:[NSMutableDictionary class]])
    {
        parametersDic = [parameters mutableCopy];
    }
    else if ( (parameters != nil) && ([parameters isKindOfClass:[NSDictionary class]]))
    {
        parametersDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }
    
    if(parametersDic.count >0)
    {
        [parametersDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            //<#code#>
            if(paramString.length==0)
            {
                paramString = [NSString stringWithFormat:@"%@=%@",key,obj];
            }
            else
            {
                paramString = [paramString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,obj]];
            }
        }];
    }
    
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息）
        if (prepareRequest) {
            prepareRequest();
        }
        switch (method) {
            case SHHttpRequestGet:
            {
                
                task=  [self.manager GET:url parameters:parametersDic success:^(NSURLSessionDataTask *task, id responseObject){
                    if (![self handleServicesStatus:responseObject]) {
                        if(success !=nil)
                            success(task, responseObject);
                    }
                } failure:failure];
            }
                break;
            case SHHttpRequestPost:
            {
                
                task=  [self.manager POST:url parameters:parametersDic success:^(NSURLSessionDataTask *task, id responseObject){
                    DLOG(@"shhttpPost====%@", responseObject);
                    if (![self handleServicesStatus:responseObject]) {
                        if(success != nil)
                            success(task, responseObject);
                    }
                    
                } failure:failure];
                
            }
                break;
            case SHHttpRequestDelete:
            {
                task= [self.manager DELETE:url parameters:parametersDic success:success failure:failure];
            }
                break;
            case SHHttpRequestPut:
            {
                task=  [self.manager PUT:url parameters:parametersDic success:success failure:false];
            }
                break;
            default:
                break;
        }
    }else{
        //网络错误
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTI_NETWORK_ERROR" object:nil];
    }
    
    
    return ;
}

- (NSString *)encryptGetParameters:(NSString *)url
{
    if (url.length == 0 || url == nil) {
        return nil;
    }
//    NSArray *arr = [url componentsSeparatedByString:@"?"];
//    NSString *last = [arr lastObject];
//    NSString *host = [arr objectAtIndex:0];
//    NSString *encryptStr = [[AppEncryptUtil SharedInstance] getEncryptString:last];
//    encryptStr = [encryptStr urlEncode];
//    NSString *result = [NSString stringWithFormat:@"%@?rq=%@", host, encryptStr];
//    DLOG(@"final url===%@", result);
    return nil;
}

- (void)requestWithMethod:(SHHttpRequestType)method
                   subUrl:(NSString *)url
             parameters:(NSDictionary *)parameters
         prepareExecute:(PrepareRequestBlock)prepareRequest
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    NSMutableDictionary *dicPar = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if (parameters) {
        [dicPar addEntriesFromDictionary:parameters];
    }
    [dicPar setObject:kCommApiKey forKey:@"apikey"];
    
    //1.拼接URL
    NSString *totalUrl = [NSString stringWithFormat:@"%@%@",kCommServerUrl,url];
    
    NSLog(@"%@",totalUrl);
    
    
    //2.发送请求
    [self requestWithPath:totalUrl method:method parameters:dicPar prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        DLOG(@"requestWithMethod return response = %@",responseObject);
        success(task,responseObject);
     
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        DLOG(@"requestWithMethod return error = %@",error);
        failure(task,error);
        
    }];
    
}


#pragma mark === get sync=====

- (void)requestSyncHttpWithPath:(NSString *)url
                     parameters:(id)parameters
                 prepareExecute:(PrepareRequestBlock)prepareBlock
                        success:(void(^)(id responseData))success
                        failure:(void(^)(NSError *error))failure
{
    //请求的URL
    DLOG(@"sync Request path:=====%@",url);
   
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息）
        if (prepareBlock) {
            prepareBlock();
        }
        NSString* encryptUrl = [self encryptGetParameters:url];
    
         NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:encryptUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (received != nil) {
            NSDictionary *dict = [LeJSONUtil JSONObjectWith:received];
            DLOG(@"sync response===%@", dict);
            success(dict);
        }else{
            NSString *str = [LeJSONUtil JSONString:received];
            DLOG(@"sync response===%@", str);
            NSError *err = [NSError errorWithDomain:@"token data is nil" code:-1 userInfo:nil];
            failure(err);
        }
    }else{
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTI_NETWORK_ERROR" object:nil];
    }
    
}

#pragma mark ==== check status 102======

- (BOOL)handleServicesStatus:(id)responseData
{
    BOOL result = NO;
    if (responseData != nil && [responseData isKindOfClass:[NSDictionary class]])
    {
        id tempResult = [responseData objectForKey:@"status"];
        if((tempResult != nil) && (![tempResult isEqual:[NSNull null]]) &&([tempResult isKindOfClass:[NSNumber class]]))
        {
            NSInteger status = [tempResult integerValue]; 
            if ((status == 403) || (status == 404))
            {
                result = YES;
            }
        }
    }
    
    return result;
}

-(void)p_exitCurrentAccount
{
//    [[ThirdSDKManager sharedInstance] exitCurrentAccount];
}


- (void)requeststatisticsWithPath:(NSString *)url
                           method:(SHHttpRequestType)method
                       parameters:(id)parameters
                   prepareExecute:(PrepareRequestBlock)prepareRequest
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //请求的URL
    DLOG(@"Request path:=====%@",url);
    NSURLSessionDataTask* task = nil;
    
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息）
        if (prepareRequest) {
            prepareRequest();
        }
        switch (method) {
            case SHHttpRequestGet:
            {
                task=  [self.manager GET:url parameters:parameters success:success failure:failure];
            }
                break;
            case SHHttpRequestPost:
            {
                task=  [self.manager POST:url parameters:parameters success:success failure:failure];
            }
                break;
            case SHHttpRequestDelete:
            {
                task= [self.manager DELETE:url parameters:parameters success:success failure:failure];
            }
                break;
            case SHHttpRequestPut:
            {
                task=  [self.manager PUT:url parameters:parameters success:success failure:false];
            }
                break;
            default:
                break;
        }
    }else{
        //网络错误
        //发出网络异常通知广播
        //[[NSNotificationCenter defaultCenter] postNotificationName:KNOTI_NETWORK_ERROR object:nil];
    }
    
    
    return ;
}


- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([self isConnectionAvailable]) {
        [self.manager HEAD:url parameters:parameters success:success failure:failure];
    }else{
        [self showExceptionDialog];
    }
}

//检查网络是不是给力
- (BOOL)isConnectionAvailable
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        DLOG(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

//弹出网络错误提示框
- (void)showExceptionDialog
{
//    [ToastUtil showToastInWindow:NONETWORK_TOTAST_TITLE];

//    [[[UIAlertView alloc] initWithTitle:@"提示"
//                                message:@"网络连接失败，请检查网络"
//                               delegate:self
//                      cancelButtonTitle:@"好的"
//                      otherButtonTitles:nil, nil] show];
}

#pragma mark ==== 上传，更新头像====
- (void)uploadImageWithUrl:(NSString *)url
                  withParameters:(id)parameters
                   WithImageData:(NSData *)data
                        fileName:(NSString *)fileName
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
//    [manager.requestSerializer setValue:kUserId forHTTPHeaderField:@"uid"];
//    [manager.requestSerializer setValue:kSSO_Token forHTTPHeaderField:@"ssotk"];
    [manager.requestSerializer setValue:@"thLC"  forHTTPHeaderField:@"appkey"];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(data != nil)
        {
            [formData appendPartWithFileData:data name:@"photo" fileName:fileName mimeType:@"image/png/jpeg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              if ([result isEqualToString:@"403"] || [result isEqualToString:@"404"]) {
                  success(result);
                  return;
              }
              if (result.length > 0) {
                  success(result);
              }
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLOG(@"头像上传错误 %@", error.localizedDescription);
                  failure(error);
          }];
}

#pragma mark === 上传 图片===
- (void)postImageWithUrl:(NSString *)url
                withParameters:(id)parameters
                 WithImagePath:(NSString *)imgUrl
                      fileName:(NSString *)fileName
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    
    NSMutableDictionary *dicPar = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if (parameters) {
        [dicPar addEntriesFromDictionary:parameters];
    }
    [dicPar setObject:kCommApiKey forKey:@"apikey"];
    
    //1.拼接URL
    NSString *totalUrl = [NSString stringWithFormat:@"%@%@",kCommServerUrl,url];
    
    NSLog(@"%@",totalUrl);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //拼接URL
    

    
    
    [manager POST:totalUrl parameters:dicPar constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:imgUrl];
        
        if(data != nil)
        {
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
            
            DLOG(@"data != nil");
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [LeJSONUtil JSONObjectWith:responseObject];
        DLOG(@"上传完成 %@", dict);
        if (![self handleServicesStatus:dict]) {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLOG(@"上传错误 %@", error.localizedDescription);
    }];

}
+ (NSURLSessionUploadTask *)uploadURL:(NSString *)urlString params:(NSDictionary *)params fileData:(NSDictionary *)filesData completion:(void (^)(id, NSError *))block{
    
    
    NSMutableDictionary *dicPar = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if (params) {
        [dicPar addEntriesFromDictionary:params];
    }
    [dicPar setObject:kCommApiKey forKey:@"apikey"];
    //1.拼接URL
    NSString *totalUrl = [NSString stringWithFormat:@"%@%@",kCommServerUrl,urlString];

    
    NSLog(@"%@",totalUrl);
    
    
    
    AFHTTPSessionManager *af = [[AFHTTPSessionManager alloc]init];
    NSURLSessionDataTask *uploadTask = [af POST:totalUrl parameters:dicPar constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [filesData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            [formData appendPartWithFileData:obj name:key fileName:@"hl.jpg" mimeType:@"image/jpeg"];
        }];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        block(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error);
    }];
    return (NSURLSessionUploadTask *)uploadTask;


}

@end
