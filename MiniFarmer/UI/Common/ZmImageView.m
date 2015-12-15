//
//  ZmImageView.m
//  Weibo
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 Qiang. All rights reserved.
//

#import "ZmImageView.h"
#import "SDWebImageManager.h"
#import <ImageIO/ImageIO.h>
@implementation ZmImageView{
    UIScrollView *_scrollV;
    UIImageView *_fullV;
    UIProgressView *_progressV;
    id <SDWebImageOperation> op;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTap];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTap];
    }
    return self;
}

- (void)addTap {
    //创建点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInAction)];
    self.userInteractionEnabled = YES;
    
    [self addGestureRecognizer:tap];
}

- (void)tapInAction {
    //回调代理对象的放大的协议方法，通知代理对象这个事件发生了
    //respondsToSelector : 判断self.delegate 是否实现了@selector()方法
    if ([self.delegate respondsToSelector:@selector(imageWillZoomin:)]) {
        [self.delegate imageWillZoomin:self];
    }
    //创建放大视图
    [self _createViews];
    //转换坐标
   CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullV.frame = frame;
    self.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _fullV.frame = _scrollV.frame;
    } completion:^(BOOL finished) {
        _scrollV.backgroundColor = [UIColor blackColor];
        if ([self.delegate respondsToSelector:@selector(imageDidZoomin:)]) {
            
            [self.delegate imageDidZoomin:self];
            
        }
    }];
    
    //加载原图图片
    if (self.original_pic.length == 0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:_original_pic];
    op = [[SDWebImageManager sharedManager] downloadWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat p = receivedSize/(CGFloat)expectedSize;
        _progressV.progress = p;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        _fullV.image = image;
        
        //处理长图图片
        CGFloat height = (image.size.height/image.size.width)*_scrollV.bounds.size.width;
        if (height>_scrollV.bounds.size.height) {
            _fullV.frame = CGRectMake(0, 0, _scrollV.bounds.size.width, height);
            _scrollV.contentSize = CGSizeMake(_fullV.bounds.size.width, _fullV.bounds.size.height);
        }
        
    }];
//    
//    //实际中需要处理GIF图片播放 在这里该框架内置有GIF播放
//    //1.WebView播放
//    //ImageIO把GIF转换成一组图片 再用UIImageView 显示
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    
//    //1.使用WeiboView播放 pathExtension 取得扩展名
//    NSString *extension = [self.original_pic pathExtension];
//    if ([extension isEqualToString:@"gif"]) {
//        //WebView 播放
//        UIWebView *webview = [[UIWebView alloc]initWithFrame:self.window.bounds];
//        webview.userInteractionEnabled = NO;
//        webview.backgroundColor = [UIColor clearColor];
//        [webview loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//        [self.window addSubview:webview];
//    }
//    //2.ImageIO 提取gif中包含的一组图片，然后使用ImageView播放
//    _fullV.image = [UIImage imageWithData:data];
////    1>创建图片源
//    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)data, NULL);
//    //2>获取图片源中包含的数量
//    size_t count = CGImageSourceGetCount(source);
//    NSMutableArray *imgs = [NSMutableArray array];
//    for (int i=0; i<count; i++) {
//        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
//        UIImage *img = [UIImage imageWithCGImage:image];
//        [imgs addObject:img];
//        
//    }
//    _fullV.animationImages = imgs;
//    _fullV.animationDuration = 0.1*count;
//    [_fullV startAnimating];
//    
//    //或者把所有图片转换成一个动画的UIImage对象
//    UIImage *gifImg = [UIImage animatedImageNamed:imgs duration:0.1*count];
//    _fullV.image = gifImg;
    
}

- (void)_createViews {
    if (_scrollV == nil) {
        _scrollV = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_scrollV];
        //self.window addSubview:_scrollV
        _fullV = [[UIImageView alloc]initWithFrame:_scrollV.bounds];
        _fullV.image = self.image;
        _fullV.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollV addSubview:_fullV];
        
        //创建UIProgreeView
        _progressV = [[UIProgressView alloc]initWithFrame:CGRectMake(0,0, _scrollV.bounds.size.width, 5)];
        _progressV.progressViewStyle = UIProgressViewStyleDefault;
        _progressV.progressTintColor = [UIColor blueColor];
        [_scrollV addSubview:_progressV];
        
        //创建手势缩小
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOutAction)];
        [_scrollV addGestureRecognizer:tap];
        
    }
}

- (void)tapOutAction {
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        _fullV.frame = [self convertRect:self.bounds toView:self.window];
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [_scrollV removeFromSuperview];
        _scrollV = nil;
        _fullV = nil;
        if ([self.delegate respondsToSelector:@selector(imageDidZoomOut:)]) {
            [self.delegate imageDidZoomOut:self];
        }
    }];
    
    //取消网络请求
    [op cancel];
}
@end
