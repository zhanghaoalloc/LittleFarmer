//
//  ZmImageView.h
//  Weibo
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 Qiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZmImageView;
@protocol ZmImageViewDelegate <NSObject>
@optional
//1.图片将要放大
- (void)imageWillZoomin:(ZmImageView *)imageView;
//2.图片已经放大
- (void)imageDidZoomin:(ZmImageView *)imageView;
//3.图片将要缩小
- (void)imageWillZoomOut:(ZmImageView *)imageView;
//4.图片已经缩小
- (void)imageDidZoomOut:(ZmImageView *)imageView;


@end

@interface ZmImageView : UIImageView
@property (nonatomic,copy)NSString *original_pic;
@property (nonatomic,weak)id<ZmImageViewDelegate>delegate;
@end
