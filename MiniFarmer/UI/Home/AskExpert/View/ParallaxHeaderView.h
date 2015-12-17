//
//  ParallaxHeaderView.h
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <UIKit/UIKit.h>



@interface ParallaxHeaderView : UIView
@property (nonatomic,strong)  UILabel *headerTitleLabel;//主题
@property (nonatomic,strong) UIImage *headerImage;//头部图片



//设置背景视图的大小和背景图 ，返回一个背景图
+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
//设置背景的大小，获得一个背景图
+ (id)parallaxHeaderViewWithCGSize:(CGSize)headerSize;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
