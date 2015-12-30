//
//  ImagesView.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/13.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ImagesView.h"
#import "MTPickerInfo.h"
#import "UIViewAdditions.h"

#define kButtonsDispace 5
#define kMaxCountOfLine 3
#define kMaxCount 6

@interface ImagesView ()<UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *items;

//拍照和相册选择都存在在此
@property (nonatomic,strong) NSMutableArray *photos;

@end

@implementation ImagesView{
    //刷新
    UIButton *btn ;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化方法里面暂时不做任何操作
        self.photos = [NSMutableArray array];
        
    }
    return self;
}

- (void)reloadDataWithImagesInfo:(NSArray *)images
{
    _photos = [NSMutableArray arrayWithArray:images];
    
    if (_photos.count==1) {
        
    }else{
        MTPickerInfo *pictureInfo = [MTPickerInfo new];
        pictureInfo.isSelectImage = YES;
        pictureInfo.image = [UIImage imageNamed:@"asd_btn_addimage"];
        [self.photos addObject:pictureInfo];
    
    }

    //设置frame
    CGFloat dwidth = ceil((CGRectGetWidth(self.frame) - (kMaxCountOfLine - 1)*kButtonsDispace)/kMaxCountOfLine);
    for (int i = 0; i<(_photos.count > kMaxCount ? kMaxCount : _photos.count); i++)
    {
    
        //如果要展示的button 在控件的容器中 还是存在的 那么就从控件中选取
        if (i < self.items.count)
        {
            btn = [self.items objectAtIndex:i];
        }
        else
        {
            //如果要展示的button 已经超过了容器的个数 那么就新创建一个出来 然后添加到容器中使用
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //添加点击事件
            btn.tag = i+1;
            [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.items addObject:btn];
        }
        
        btn.frame = CGRectMake(((i - kMaxCountOfLine) >= 0 ? (i - kMaxCountOfLine) : i ) * (dwidth + kButtonsDispace), (i / kMaxCountOfLine) * (dwidth + kButtonsDispace), dwidth, dwidth);
        
        MTPickerInfo *info = [_photos objectAtIndex:i];
        //设置btn的图片
        
        [btn setBackgroundImage:info.image forState:UIControlStateNormal];
        
        //添加视图
        [self addSubview:btn];
        
    }
    //去掉容器中多余的控件
    for (int j = self.items.count - 1; j >= images.count; j--)
    {
        UIButton *btn = [self.items objectAtIndex:j];
        [btn removeFromSuperview];
        [self.items removeObject:btn];
    }
    //更新self的frame
    CGRect newRect = self.frame;
    newRect.size.height = images.count > 3 ? (dwidth * 2 + kButtonsDispace) : dwidth;
    self.frame = newRect;
    
}

- (NSMutableArray *)items
{
    if (!_items)
    {
        _items = [[NSMutableArray alloc] initWithCapacity:7];
        
    }
    return _items;
}

- (void)tapBtn:(UIButton *)button
{
    NSInteger tag = button.tag;
    
     if(tag<self.items.count)
    {
        
    [self.delegate imagesView:self selectedItem:[self.items indexOfObject:btn]];
    
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(imagesView:selectedItem:)])
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
            [actionSheet showInView:self.viewController.view];
        }

    
    }
}
#pragma mark-----UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {//拍照
        UIImagePickerController *pickerImg = [[UIImagePickerController alloc] init];
        pickerImg.sourceType =UIImagePickerControllerSourceTypeCamera;
        pickerImg.delegate = self;
        
        [self.viewController presentViewController:pickerImg animated:YES completion:NULL];
        
    }else if (buttonIndex == 1){//相册
    
      [self.delegate imagesView:self selectedItem:[self.items indexOfObject:btn]];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSString *mediaType = info[@"UIImagePickerControllerMediaType"];
    
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    
    MTPickerInfo *pictureInfo = [MTPickerInfo new];
    pictureInfo.isSelectImage = YES;
    pictureInfo.image = img;
    
    NSArray * array = [NSArray arrayWithObject:pictureInfo];
    
    
    [self reloadDataWithImagesInfo:array];
    
    
    if ([mediaType isEqualToString:@"public.image"]) {  //照片类型
        
             //判断照片是否来自与摄像头
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //保存图片到相册
           UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            [self.viewController dismissViewControllerAnimated:YES completion:NULL];
            
        }
    }
}
//取消按钮被点击
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
   //关闭窗口
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
//存储照片到相册成功之后调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
}


@end
