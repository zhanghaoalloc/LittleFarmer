//
//  ZoomScrollView.m
//  Photoes
//
//  Created by neal on 14-7-19.
//

#import "ZoomScrollView.h"

@interface ZoomScrollView()
{
    UIImageView *_imageView;
}

@end

@implementation ZoomScrollView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置默认值  最大比例3  最小比例0.5
        //外界可以自己改这个值
        self.maximumZoomScale = 5;
        self.minimumZoomScale = 1;
        self.delegate = self;
        self.backgroundColor = [UIColor blackColor];
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _imageView.backgroundColor = [UIColor redColor];
//        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        // Initialization code
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.zoomScale <= 1) {
        //当缩放比率小于1的时候,让imageView居中显示
        _imageView.center = CGPointMake(scrollView.bounds.size.width/2, scrollView.bounds.size.height/2);
    }
    else
    {
        CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
            CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
             _imageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
    }
    
}

- (void)setImage:(UIImage *)image
{
    [_imageView setImage:image];
}

@end
