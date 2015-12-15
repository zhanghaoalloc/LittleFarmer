//
//  PhotoScrollView.h
//  图片浏览
//
//  Created by 牛筋草 on 15/12/1.
//  Copyright © 2015年 牛筋草. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScrollView : UIScrollView<UIScrollViewDelegate>{

   UIImageView *_imageView;
}

@property(nonatomic,retain)NSURL *url;

@end
