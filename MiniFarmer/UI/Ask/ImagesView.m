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

#import "ZLPhotoAssets.h"

#define kButtonsDispace 5
#define kMaxCountOfLine 3
#define kMaxCount 6

@interface ImagesView ()<UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic ,strong) NSMutableArray *assets;

@end

@implementation ImagesView{


}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
       
    }
    return self;
}
#pragma getdata;


- (void)reloadDataWithImagesInfo:(NSArray *)images
{
    //设置frame
    CGFloat dwidth = ceil((CGRectGetWidth(self.frame) - (kMaxCountOfLine - 1)*kButtonsDispace)/kMaxCountOfLine);
    
    for (int i = 0; i<(images.count > kMaxCount ? kMaxCount : images.count); i++)
    {
        //刷新
        UIButton *btn ;
        //如果要展示的button 在控件的容器中 还是存在的 那么就从控件中选取
        if (i < self.items.count)
        {
            btn = [self.items objectAtIndex:i];
        }
        else
        {
            //如果要展示的button 已经超过了容器的个数 那么就新创建一个出来 然添加到容器中使用
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //添加点击事件
            [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.items addObject:btn];
        }
        btn.frame = CGRectMake(((i - kMaxCountOfLine) >= 0 ? (i - kMaxCountOfLine) : i ) * (dwidth + kButtonsDispace), (i / kMaxCountOfLine) * (dwidth + kButtonsDispace), dwidth, dwidth);
        
        id info = [images objectAtIndex:i];
        if ([info isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)info;
             [btn setBackgroundImage:image forState:UIControlStateNormal];
        }else if([info  isKindOfClass:[ZLPhotoAssets class]]){
            ZLPhotoAssets *assets = (ZLPhotoAssets *)info;
            [btn setBackgroundImage:assets.thumbImage forState:UIControlStateNormal];
        }else if([info isKindOfClass:[MTPickerInfo class]]){
            MTPickerInfo *pickerinfo = (MTPickerInfo *)info;
            
            [btn setBackgroundImage:pickerinfo.image forState:UIControlStateNormal];
        }
        //设置btn的图片
        //添加视图
        [self addSubview:btn];
    }
    //去掉容器中多余的控件
    for (NSInteger j = self.items.count - 1; j >= images.count; j--)
    {
        UIButton *button = [self.items objectAtIndex:j];
        [button removeFromSuperview];
        [self.items removeObject:button];
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
    [self.viewController.view endEditing:YES];
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(imagesView:selectedItem:)]) {
        [self.delegate imagesView:self selectedItem:[self.items indexOfObject:button]];
    }
 
}


- (void)clearPicture{

   // [self removeAllSubviews];

}
@end
