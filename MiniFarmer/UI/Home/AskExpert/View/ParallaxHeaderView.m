//
//  ParallaxHeaderView.m
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <QuartzCore/QuartzCore.h>

#import "ParallaxHeaderView.h"
#import "UIImage+ImageEffects.h"
#import "UIViewAdditions.h"

@interface ParallaxHeaderView ()
@property (strong, nonatomic)  UIScrollView *imageScrollView;//滚动视图
@property (strong, nonatomic)  UIImageView *imageView;//图片视图
@property (nonatomic,strong)  UIImageView *bluredImageView;//毛玻璃视图

//定义视图
@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rigthButton;
@property (nonatomic,strong)UIButton *backButton;

@end

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

static CGFloat kParallaxDeltaFactor = 0.5f;
static CGFloat kMaxTitleAlphaOffset = 100.0f;
static CGFloat kLabelPaddingDist = 8.0f;

@implementation ParallaxHeaderView

+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    headerView.headerImage = image;
    [headerView initialSetup];
    return headerView;
    
}

+ (id)parallaxHeaderViewWithCGSize:(CGSize)headerSize;
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    [headerView initialSetup];
    return headerView;
}


- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
    CGRect frame = self.imageScrollView.frame;
    
    if (offset.y > 0)
    {
        frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
        self.imageScrollView.frame = frame;
        self.bluredImageView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y * 2;
        self.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.imageScrollView.frame = rect;
        self.clipsToBounds = NO;
        self.headerTitleLabel.alpha = 1 - (delta) * 1 / kMaxTitleAlphaOffset;
        
    }
}

#pragma mark -
#pragma mark Private

- (void)initialSetup
{   self.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //1.滚动视图
    self.imageScrollView = scrollView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = self.headerImage;
    self.imageView = imageView;
    [self.imageScrollView addSubview:imageView];
    
    CGRect labelRect = self.imageScrollView.bounds;
    labelRect.origin.x = labelRect.origin.y = kLabelPaddingDist;
    labelRect.size.width = labelRect.size.width - 2 * kLabelPaddingDist;
    labelRect.size.height = labelRect.size.height - 2 * kLabelPaddingDist;
    //2.标题视图
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:labelRect];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.numberOfLines = 0;
    headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    headerLabel.autoresizingMask = imageView.autoresizingMask;
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:23];
    self.headerTitleLabel = headerLabel;
    [self.imageScrollView addSubview:self.headerTitleLabel];

    //3.毛玻璃视图
    self.bluredImageView = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    self.bluredImageView.autoresizingMask = self.imageView.autoresizingMask;
    self.bluredImageView.alpha = 0.0f;
    //[self.imageScrollView addSubview:self.bluredImageView];
    
    [self addSubview:self.imageScrollView];
    
    //4.两个操作按钮
    
    CGFloat width = (kScreenSizeWidth-12-12-15)/2;
    double   time = (double)82/336;
    CGRect subRect;
    subRect.size.width = width;
    subRect.size.height = width*time;
    subRect.origin.x = 12;
    subRect.origin.y = self.bounds.size.height-width*time-12;
    //左边
    self.leftButton = [self button];
    [self.leftButton setTitle:@"向专家提问" forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"home_expert_ask_expert"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.leftButton setBackgroundImage:image forState:UIControlStateNormal];
    self.leftButton.frame = subRect;
    [self addSubview:self.leftButton];
    
    //右边
    subRect.origin.x = 12+15+width;
    self.rigthButton = [self button];
    [self.rigthButton setBackgroundImage:[UIImage imageNamed:@"home_expert_attention"] forState:UIControlStateNormal];
    [self.rigthButton setTitle:@"加关注" forState:UIControlStateNormal];
     self.rigthButton.backgroundColor = [UIColor redColor];
     self.rigthButton.frame = subRect;
    [self  addSubview:self.rigthButton];
    //5.返回按钮
    UIButton *backbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:[UIImage imageNamed:@"home_expert_detail_back_btn"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton = backbutton;
    self.backButton.frame = CGRectMake(0, kStatusBarHeight, kNavigationBarHeight, kNavigationBarHeight);
    
    [self.imageScrollView addSubview:self.backButton];
    
    
    
    

    
    
    
    
        [self refreshBlurViewForNewImage];
}
#pragma mark---子视图的初始化
- (UIButton *)button{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    button.titleLabel.font = kTextFont16;

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

//头视图的图片
- (void)setHeaderImage:(UIImage *)headerImage
{
    _headerImage = headerImage;
    self.imageView.image = headerImage;
    [self refreshBlurViewForNewImage];
}

- (UIImage *)screenShotOfView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(kDefaultHeaderFrame.size, YES, 0.0);
    [self drawViewHierarchyInRect:kDefaultHeaderFrame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)refreshBlurViewForNewImage
{
    UIImage *screenShot = [self screenShotOfView:self];
    screenShot = [screenShot applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.6 alpha:0.2] saturationDeltaFactor:1.0 maskImage:nil];
    self.bluredImageView.image = screenShot;
}

#pragma mark---按钮的点击事件
- (void)buttonAction:(UIButton *)button{



}
- (void)backAction:(UIButton *)button{

    [self.viewController.navigationController popViewControllerAnimated:YES];

}
@end

