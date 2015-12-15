//
//  SHHttpClient.h
//  baby
//
//  Created by lic on 15/1/8.
//  Copyright (c) 2015年 lic. All rights reserved.
//
//  网络请求

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class NSURLSessionDataTask;

//HTTP REQUEST METHOD TYPE
typedef NS_ENUM(NSInteger, SHHttpRequestType) {
    SHHttpRequestGet,
    SHHttpRequestPost,
    SHHttpRequestDelete,
    SHHttpRequestPut,
};

// 请求开始前预处理Block
typedef void (^PrepareRequestBlock)(void);


@interface SHHttpClient : NSObject

+ (SHHttpClient *)defaultClient;

//判断当前网络状态
- (BOOL)isConnectionAvailable;
- (void)showExceptionDialog;
/**
 *  HTTP请求（GET、POST、DELETE、PUT）
 *
 *  @param path
 *  @param method     请求类型
 *  @param parameters 请求参数
 *  @param prepare    请求前预处理块
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */
- (void)requestWithPath:(NSString *)url
                 method:(SHHttpRequestType)method
             parameters:(id)parameters
         prepareExecute:(PrepareRequestBlock)prepareRequest
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  HTTP请求（GET、POST、DELETE、PUT）,用以固定url地址（kCommServerUrl）请求，以及在parameters增加固定请求参数
 *
 *  @param method     请求类型
 *  @param parameters 请求参数
 *  @param prepare    请求前预处理块
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */

- (void)requestWithMethod:(SHHttpRequestType)method
                   subUrl:(NSString *)url
               parameters:(NSDictionary *)parameters
           prepareExecute:(PrepareRequestBlock)prepareRequest
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  HTTP请求（HEAD）
 *
 *  @param path
 *  @param parameters
 *  @param success
 *  @param failure
 */
- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


- (void)requeststatisticsWithPath:(NSString *)url
                 method:(SHHttpRequestType)method
             parameters:(id)parameters
         prepareExecute:(PrepareRequestBlock)prepareRequest
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  get 同步请求
 *
 *  @param url          url
 *  @param parameters   参数
 *  @param prepareBlock 预处理
 *  @param success      成功回调
 *  @param failure      失败回调
 */
- (void)requestSyncHttpWithPath:(NSString *)url
                     parameters:(id)parameters
                 prepareExecute:(PrepareRequestBlock)prepareBlock
                        success:(void(^)(id responseData))success
                        failure:(void(^)(NSError *error))failure;

/**
 *  //上传头像
 *
 *  @param url      服务器地址
 *  @param imgUrl   图片路径
 *  @param fileName 文件名，不能为空
 *  @param success  成功
 *  @param failure  失败
 */
- (void)postImageWithUrl:(NSString *)url
           withParameters:(id)parameters
            WithImagePath:(NSString *)imgUrl
                       fileName:(NSString *)fileName
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;


- (void)uploadImageWithUrl:(NSString *)url
                  withParameters:(id)parameters
                   WithImageData:(NSData *)data
                        fileName:(NSString *)fileName
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;
//上传图片
+ (NSURLSessionUploadTask *)uploadURL:(NSString *)urlString
                               params:(NSDictionary *)params  //文本参数
                             fileData:(NSDictionary *)filesData   //图片参数
                           completion:(void(^)(id result,NSError *error))block;
@end
