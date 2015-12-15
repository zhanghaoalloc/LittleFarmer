//
//  PhotoScrollView.m
//  图片浏览
//
//  Created by 牛筋草 on 15/12/1.
//  Copyright © 2015年 牛筋草. All rights reserved.
//

#import "PhotoScrollView.h"
#import "UIImageView+WebCache.h"
#import "UIView+UIViewController.h"
#import "UIImage+WebP.h"
#import "UIImageView+HighlightedWebCache.h"


@implementation PhotoScrollView{
  
    
    UIImageView * imagev;
    



}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
       
    
        //设置最大最小的缩放倍数
        self.maximumZoomScale = 2;
        self.minimumZoomScale = 1;
        
        //设置隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //
        self.delegate = self;
        
        //双击手势
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
        tap2.numberOfTapsRequired = 2;   // 点击的次数
        tap2.numberOfTouchesRequired = 1;  //点击所使用的手指数
        [self addGestureRecognizer:tap2];
        //单击手势
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
        [self addGestureRecognizer:tap1];
        
        
        
        //当tap2手势触发的时候，让tap1失效
        [tap1 requireGestureRecognizerToFail:tap2];
        
        
        
        
        
    }
    return self;
}

- (void)tapAction2:(UITapGestureRecognizer *)tap{
    
    //    NSLog(@"%@",tap);
    //    NSLog(@"%@",tap.view);
    
    //    self.zoomScale  //scrollView对子视图缩放的倍数
    
    if (self.zoomScale > 1) {  //大于1,说明已经放大了
        [self setZoomScale:1 animated:YES];
    } else {
        [self setZoomScale:2 animated:YES];
    }
    
    // NSLog(@"双击");
}
- (void)tapAction1:(UITapGestureRecognizer *)tap{
    
    [self.ViewController.navigationController popViewControllerAnimated:YES];
}


- (void)setUrl:(NSURL *)url{
    _url = url;
    //[_imageView setImageWithURL:_url];

    
   // [_imageView sd_setImageWithURL:_url];
    
   // [_imageView sd_setImageWithURL:_url placeholderImage:[UIImage imageNamed:@"Sys_defalut"]];
     
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
    
    
    [_imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:_url]]];
    
   // [_imageView sd_setImageWithURL:_url placeholderImage:nil];
    

    
      
}


#pragma mark - UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

@end
