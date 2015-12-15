////
////  BBHttpService.m
////  baby
////
////  Created by lic on 15/1/14.
////  Copyright (c) 2015年 lic. All rights reserved.
////
//
//#import "LeHttpService.h"
//
//@implementation LeHttpService
//
//+ (LeHttpService *)shareLeHttpService
//{
//    static LeHttpService *instance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        instance = [[self alloc] init];
//    });
//    return instance;
//}
//
//- (NSString *)requestUrlWithPath:(NSString *)path
//{
////    return [kHostUrl stringByAppendingString:path];
//    return nil;
//}
//
//#pragma mark ==== update image ====
//- (void)uploadHeaderImage:(NSData*)imgData
//{
//    [[SHHttpClient defaultClient] uploadImageWithUrl:kUpLoadHost
//                                      withParameters:nil
//                                       WithImageData:imgData
//                                            fileName:@"userHeaderImg"
//                                             success:^(id responseObject) {
//                                                 NSString *result = (NSString *)responseObject;
//                                                 DLOG(@"resp====%@", result);
//                                                 if (result.length > 0) {
//                                                     if ([result isEqualToString:@"403"] || [result isEqualToString:@"404"]) {
//                                                         _leFailedBlock(@"failed");
//                                                         return;
//                                                     }
//                                                     self.imageId = result;
//                                                     [self updateHeaderImage];
//                                                 }else{
//                                                     
//                                                     _leFailedBlock(@"failed");
//                                                 }
//                                                 
//                                                 
//                                             } failure:^(NSError *error) {
//                                                 DLOG(@"error====%@", error);
//                                                 _leFailedBlock(@"failed");
//                                             }];
//
//}
//
//#pragma mark ==== update image ====
//- (void)updateHeaderImage
//{
////    http://media.lehi.letv.com/images.do?imageId=101010002_200_200
//    NSString *uploadPath = [NSString  stringWithFormat:@"%@imageId=%@", kDownloadHost, _imageId];
//    NSDictionary *dict = @{@"iconKey": uploadPath};
//    [CommonNetwork requestWithCmd:@"updateUserIcon"
//                           params:dict
//                          success:^(id result) {
//                              if (![APPHelper isReturnError:result]) {
//                                  DLOG(@"update pic success !!!");
//                                  [CustomUserDefaults customSetObject:uploadPath forKey:UserDefaultsKeyUserAvatar];
//                                  _leSuccessBlock(result);
//                              }
//                              else{
//                                  DLOG(@"update pic failed !!!");
//                                  _leFailedBlock(@"failed");
//                              }
//                          }
//                          failure:^(NSError *error) {
//                              DLOG(@"update error");
//                              _leFailedBlock(@"failed");
//                          }];
//}
//
//#pragma mark === upload video img ====
//
//- (void)uploadVideoCoverPhoto:(NSData *)imgData
//{
//    [[SHHttpClient defaultClient] uploadImageWithUrl:kUpLoadHost
//                                      withParameters:nil
//                                       WithImageData:imgData
//                                            fileName:@"videoCoverImg"
//                                             success:^(id responseObject) {
//                                                 NSString *result = (NSString *)responseObject;
//                                                 DLOG(@"resp====%@", result);
//                                                 if (result.length > 0) {
//                                                     if ([result isEqualToString:@"403"] || [result isEqualToString:@"404"]) {
//                                                         return;
//                                                     }
//                                                     self.imageId = result;
//                                                     [self updateVideoCover];
//                                                 }
//                                             } failure:^(NSError *error) {
//                                                 DLOG(@"error====%@", error);
//                                             }];
//
//}
//
//- (void)updateVideoCover
//{
//    NSString *proId = [NSString stringWithFormat:@"%@", [CustomUserDefaults customObjectForKey:kCurrentLiveProgramId]];
//    NSString *uploadPath = [NSString  stringWithFormat:@"%@imageId=%@", kDownloadHost, _imageId];
//    DLOG(@"uploadPath===%@", uploadPath);
//    NSDictionary *dict = @{@"programId": proId, @"picKey": uploadPath};
//    [CommonNetwork requestWithCmd:@"updateProgramPic"
//                           params:dict
//                          success:^(id result) {
//                              DLOG(@"update video picture success !!!");
//                          }
//                          failure:^(NSError *error) {
//                              DLOG(@"update video picture failed !!!");
//                              
//                          }];
//}
//
//@end
