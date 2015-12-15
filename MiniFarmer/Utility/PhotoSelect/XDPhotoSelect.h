//
//  XDPhotoSelect.h
//  leCar
//
//  Created by Li Zhiping on 14-1-16.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XDPhotoSelect;

@protocol XDPhotoSelectDelegate <NSObject>
@optional

//选择完成后的回调
- (void)photoSelect:(XDPhotoSelect *)photoSelect didFinishedWithImageArray:(NSArray *)imageArray;

//照片选择取消后的回调
- (void)photoSelectDidCancelled:(XDPhotoSelect *)photoSelect;

@end

typedef enum{
    XDPhotoSelectTakePhoto, //拍照
    XDPhotoSelectFromLibrary,//从相册中读取
    XDPhotoSelectUserSelect //用户手动选择
}XDPhotoSelectType;

@interface XDPhotoSelect : NSObject

/**
 *  PhotoSelect Designated init method
 *
 *  @param viewController 需要 push or model 方式弹出Controller时的父Controller
 *  @param delegate       图片选择完成后的回调
 *
 *  @return
 */
- (id)initWithController:(UIViewController *)viewController delegate:(id<XDPhotoSelectDelegate>)delegate;

/**
 *  用户最多能选择的照片数, default is 0
 */
@property (assign, nonatomic)NSInteger maxSelectCount;

/**
 *  选择的图片是否需要编辑，只用于选择一张图片的情况, default is NO
 */
@property (assign, nonatomic)BOOL needEdit;

/**
 *  是否是多个图片选择, default is NO
 */
@property (assign, nonatomic, getter = isMultiPickImage)BOOL multiPickImage;

/**
 *  开始选取照片
 *  1、选择成功后, 会将之前选择的照片清空, 需要手动保存之前选择的照片
 *  2、如果只是开始选择照片, 但取消拍照或者选择照片, 不会清空
 *
 *  @param type 选取照片时, 需要使用的类型
 */
- (void)startPhotoSelect:(XDPhotoSelectType)type;

/**
 *  返回已选择的image数组, 由 UIImage 组成
 *
 *  @return
 */
- (NSArray *)selectedImageArray;

@end
