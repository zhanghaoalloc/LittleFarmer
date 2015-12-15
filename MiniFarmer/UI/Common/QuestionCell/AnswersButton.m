//
//  AnswersButton.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AnswersButton.h"

@implementation AnswersButton


-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width - kAnsBtnImgWidth - kAnsBtnSpace;
    CGFloat titleX = contentRect.size.width - titleW;
    CGFloat titleH = kAnsBtnTitleHeight;
    CGFloat titleY = (contentRect.size.height-kAnsBtnTitleHeight)/2;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = kAnsBtnImgWidth;
    CGFloat imageH = kAnsBtnImgHeight;
    CGFloat imageY = (contentRect.size.height - kAnsBtnImgHeight)/2;
    
    return CGRectMake(0, imageY, imageW, imageH);
    
}

@end
