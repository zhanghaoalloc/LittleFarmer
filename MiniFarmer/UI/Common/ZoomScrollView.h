//
//  ZoomScrollView.h
//  Photoes
//
//  Created by neal on 14-7-19.
//

#import <UIKit/UIKit.h>

//这是一个自身能放大缩小的Scrollview.自带一个与之等大的imageView,缩放也作用于这个imageView的.

@interface ZoomScrollView : UIScrollView<UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setImage:(UIImage *)image;
@end
