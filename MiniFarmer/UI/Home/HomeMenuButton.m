//
//  HomeMenuButton.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "HomeMenuButton.h"

@implementation HomeMenuButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width;
    //CGFloat titleX = contentRect.size.width - titleW;
    CGFloat titleH = contentRect.size.height-kMenuBtnImgHeight;
    CGFloat titleY = kMenuBtnImgHeight;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = kMenuBtnImgHeight;
    //CGFloat imageY = (contentRect.size.height - kAnsBtnImgHeight)/2;
    
    return CGRectMake(0, 0, imageW, imageH);
}

@end
