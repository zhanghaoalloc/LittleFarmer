//
//  XDPhotoSelect.m
//  leCar
//
//  Created by Li Zhiping on 14-1-16.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPhotoSelect.h"
#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "XDPhotoAssetGroupViewController.h"

@interface XDPhotoSelect ()
<
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (strong, nonatomic)NSMutableArray *imageArray;

@property (weak, nonatomic)id <XDPhotoSelectDelegate>delegate;

@property (weak, nonatomic)UIViewController *viewController;

@end

@implementation XDPhotoSelect

- (id)initWithController:(UIViewController *)viewController delegate:(id<XDPhotoSelectDelegate>)delegate{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.delegate = delegate;
        self.imageArray = [NSMutableArray array];
        
        _needEdit = YES;
    }
    return self;
}

- (void)startPhotoSelect:(XDPhotoSelectType)type{
    
    switch (type) {
        case XDPhotoSelectUserSelect:
            [self showActionSheet];
            break;
        case XDPhotoSelectTakePhoto:
            [self showTakePhotoView];
            break;
        case XDPhotoSelectFromLibrary:
            [self showPhotoSelectView];
            break;
            
        default:
            break;
    }
}

- (void)showActionSheet{
    UIActionSheet *actionSheet =nil;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // localize
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片来源"
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"从手机相册选择",@"拍照", nil];
    }else{
        // localize
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片来源"
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"从手机相册选择",nil];
    }
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [actionSheet showInView:window];
}

- (void)showTakePhotoView{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = !self.isMultiPickImage;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.viewController presentViewController:picker animated:YES completion:NULL];
}

- (void)showPhotoSelectView{
    //如果不是多选, 则使用系统的控件来进行选择
    if (!self.isMultiPickImage) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = self.needEdit;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.viewController presentViewController:picker animated:YES completion:NULL];
    }else{
        XDPhotoAssetGroupViewController *groupVC = [[XDPhotoAssetGroupViewController alloc] initWithStyle:UITableViewStylePlain];
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:groupVC];
        [self.viewController presentViewController:nvc
                                          animated:YES
                                        completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex == 0) {
            [self showPhotoSelectView];
        }else if(buttonIndex == 1){
            [self showTakePhotoView];
        }
    }
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSArray *imageArray = nil;
    if (info[UIImagePickerControllerEditedImage]) {
        imageArray = @[info[UIImagePickerControllerEditedImage]];
    }else if(info[UIImagePickerControllerOriginalImage]){
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        orgImage = [self scaleToSize:orgImage size:CGSizeMake(640, 960)];
        imageArray = @[orgImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self selectedFinished:imageArray];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self selectedCancelled];
    }];
}

#pragma mark - XDMultiPhotoPickerDelegate

- (void)multiImagePickerController:(UIViewController *)picker didFinishPickingMediaWithArray:(NSArray *)imageArray{
    [self selectedFinished:imageArray];
}

- (void)multiImagePickerControllerDidCancel:(UIViewController *)picker{
    [self selectedCancelled];
}

- (void)selectedFinished:(NSArray *)imageArray{
    
    //先清空之前保存的照片列表
    [self.imageArray removeAllObjects];
    
    [self.imageArray addObjectsFromArray:imageArray];
    if ([self.delegate respondsToSelector:@selector(photoSelect:didFinishedWithImageArray:)])
    {
        [self.delegate photoSelect:self didFinishedWithImageArray:self.imageArray];
    }
}

- (void)selectedCancelled{
    if ([self.delegate respondsToSelector:@selector(photoSelectDidCancelled:)])
    {
        [self.delegate photoSelectDidCancelled:self];
    }
}

- (NSArray *)selectedImageArray{
    return self.imageArray;
}

- (void)dealloc{
    
}

@end
