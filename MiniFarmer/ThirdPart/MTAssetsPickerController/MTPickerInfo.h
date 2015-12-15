//
//  MTPickerInfo.h
//  AssetDemo
//
//  Created by renqingyang on 15/6/23.
//  Copyright (c) 2015年 renqingyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef enum
{
    camera = 1,
    album = 2,
}PhotoTypeEnum;
@interface MTPickerInfo : NSObject

@property(nonatomic,strong) ALAsset *asset;

@property(nonatomic,copy) UIImage *image;

@property(nonatomic,copy) UIImage *fullScreenImage;

@property(nonatomic,assign) NSInteger photoType;
@property(nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL isSelectImage;
- (void)bind:(ALAsset *)asset;

@end
