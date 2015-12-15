//
//  SimpleImageTitleButton.m
//  Lepai
//
//  Created by junbo jia on 14/11/15.
//  Copyright (c) 2014年 Letv. All rights reserved.
//

#import "SimpleImageTitleButton.h"

#define kDefaultTitleFontSize 11

@implementation SimpleImageTitleButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self setTitleFont:[UIFont systemFontOfSize:kDefaultTitleFontSize]];
    }
    
    return self;
}

// 图上 字下
- (void)setTopImageSize:(CGSize)imageSize imageTopHeight:(float)imageTop titleBottomHeight:(float)titleBottom
{
    float titleTop = imageTop + imageSize.height;
    
    // UIEdgeInsetsMake(top, left, bottom, right) 四个参数的意思，是你设置的这个title内容离这个btn每个边的距离是多少
    float imageLeft = (CGRectGetWidth(self.frame) - imageSize.width) / 2;
    float imageBottomHeight = CGRectGetHeight(self.frame) - titleTop;
    [self setImageEdgeInsets:UIEdgeInsetsMake(imageTop, imageLeft, imageBottomHeight, imageLeft)];
    
    // 图片 title 上下布局 图按照逻辑设置edge，文字重点是left:(－image width)，right: (0)
    // 图片 title 左右布局 要设置contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft，这样才能让不同长度的title都向左对齐，不然文字以width居中对齐
    [self setTitleEdgeInsets:UIEdgeInsetsMake(titleTop, -imageSize.width, titleBottom, 0)];
    // self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

// 字上 图下
- (void)setBottomImageSize:(CGSize)imageSize imageBottomHeight:(float)imageBottom titleTopHeight:(float)titleTop
{
    float titleBottom = imageBottom + imageSize.height;
    
    // 图片 title 上下布局 图按照逻辑设置edge，文字重点是left:(－image width)，right: (0)
    // 图片 title 左右布局 要设置contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft，这样才能让不同长度的title都向左对齐，不然文字以width居中对齐
    [self setTitleEdgeInsets:UIEdgeInsetsMake(titleTop, -imageSize.width, titleBottom, 0)];
    // self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // UIEdgeInsetsMake(top, left, bottom, right) 四个参数的意思，是你设置的这个title内容离这个btn每个边的距离是多少
    float imageLeft = (CGRectGetWidth(self.frame) - imageSize.width) / 2;
    float imageTopHeight = CGRectGetHeight(self.frame) - titleBottom;
    [self setImageEdgeInsets:UIEdgeInsetsMake(imageTopHeight, imageLeft, imageBottom, imageLeft)];
    
}

// 图左 字右
- (void)setLeftImageSize:(CGSize)imageSize imageLeftWidth:(float)imageLeft titleToImageWidth:(float)titleToImageWidth
{
    // UIEdgeInsetsMake(top, left, bottom, right) 四个参数的意思，是你设置的这个title内容离这个btn每个边的距离是多少
    float imageTop = (self.frame.size.height - imageSize.height) / 2;
    float imageRight = self.frame.size.width - imageSize.width - imageLeft;
    [self setImageEdgeInsets:UIEdgeInsetsMake(imageTop, imageLeft, imageTop, imageRight)];
    
    // button setImage 之后 文字水平方向默认都不是居中了（水平），垂直方向可以按逻辑设置，水平方向要研究偏移
    // 默认 image title 都是居中对齐，对于文字左对其，不同文字，长短不同，要设置contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft，并且title有个潜在的距离左边的宽度，（把图位置放在文字右边，title to image为0，title不能贴左边，有个7px的宽度，但image size不同，相同的titleToImageWidth，真实间距还是会变）
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    float titleLeft = imageLeft + titleToImageWidth;
    
    BOOL symmetry = NO;
    if (symmetry)
    {
        // 这样 让文字距离button左右对称
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, titleLeft, 0, titleLeft)];
    }
    else
    {
        // 这样 图左 文右 基本上都是让文字占据右边的整个区域
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, titleLeft, 0, -kTitleToButtonLeftPotentialWidth)];
    }
}

// 字左 图右
- (void)setRightImageSize:(CGSize)imageSize imageRightWidth:(float)imageRight titleToImageWidth:(float)titleToImageWidth
{
    // UIEdgeInsetsMake(top, left, bottom, right) 四个参数的意思，是你设置的这个title内容离这个btn每个边的距离是多少
    float imageTop = (self.frame.size.height - imageSize.height) / 2;
    float imageLeft = self.frame.size.width - imageSize.width - imageRight;
    [self setImageEdgeInsets:UIEdgeInsetsMake(imageTop, imageLeft, imageTop, imageRight)];
    
    // image正常计算
    // UIControlContentHorizontalAlignmentRight，title距离右边宽度为固定宽度可以计算出，然后title左边设为0，但不贴左边，再设左边为－x，可在title巨长时，title最大贴左边，不超出也不留白
    float titleRight = imageRight + imageSize.width + titleToImageWidth;
    float titleLeft = -(imageRight + imageSize.width - kTitleToButtonLeftPotentialWidth);
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, titleLeft, 0, titleRight)];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateSelected];
}

- (void)setTitleFont:(UIFont *)font
{
    [self.titleLabel setFont:font];
}

- (void)setNMImage:(UIImage *)nmImage HLImage:(UIImage *)hlImage SELImage:(UIImage *)selImage
{
    [self setImage:nmImage forState:UIControlStateNormal];
    [self setImage:hlImage forState:UIControlStateHighlighted];
    [self setImage:selImage forState:UIControlStateSelected];
}

- (void)setBGNMImage:(UIImage *)nmImage HLImage:(UIImage *)hlImage SELImage:(UIImage *)selImage
{
    [self setBackgroundImage:nmImage forState:UIControlStateNormal];
    [self setBackgroundImage:hlImage forState:UIControlStateHighlighted];
    [self setBackgroundImage:selImage forState:UIControlStateSelected];
}

- (void)setTitleNMColor:(UIColor *)nmColor HLColor:(UIColor *)hlColor SELColor:(UIColor *)selColor
{
    [self setTitleColor:nmColor forState:UIControlStateNormal];
    [self setTitleColor:hlColor forState:UIControlStateHighlighted];
    [self setTitleColor:selColor forState:UIControlStateSelected];
}

@end
