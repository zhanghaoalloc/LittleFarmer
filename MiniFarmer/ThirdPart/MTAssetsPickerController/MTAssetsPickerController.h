//
//  QCAssetsPickController.h
//  MengCampus
//
//  Created by renqingyang on 15/3/5.
//  Copyright (c) 2015年 QiCool. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

static NSInteger maximumNumberOfSelection;

@protocol MTAssetsPickerControllerDelegate;

@interface MTAssetsPickerController : UINavigationController

@property (nonatomic, weak) id <UINavigationControllerDelegate, MTAssetsPickerControllerDelegate> delegate;

@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

@property (nonatomic, assign) BOOL showsCancelButton;

+ (void) selections:(NSArray *)array withMaximNum:(NSInteger)num;
@end

@protocol MTAssetsPickerControllerDelegate <NSObject>

- (void)mt_AssetsPickerController:(MTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;

@optional

- (void)mt_AssetsPickerControllerDidCancel:(MTAssetsPickerController *)picker;

@end
