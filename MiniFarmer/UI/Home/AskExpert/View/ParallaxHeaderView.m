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
#import "UIView+FrameCategory.h"
@interface ParallaxHeaderView ()
@property (strong, nonatomic)  UIScrollView *imageScrollView;//滚动视图
@property (strong, nonatomic)  UIImageView *imageView;//图片视图
@property (nonatomic,strong)  UIImageView *bluredImageView;//毛玻璃视图

//定义视图
@property (nonatomic,strong)UIButton *leftButton;//问专家按钮
@property (nonatomic,strong)UIButton *rigthButton;//加关注按钮
@property (nonatomic,strong)UIButton *backButton;//导航栏返回按钮

//头像
@property (nonatomic,strong)UIView *iconView;
@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UIImageView *expertTypeImage;

//专家类型,
@property (nonatomic,strong)UIView *expertTypeView;
@property (nonatomic,strong)UILabel *expertName;
@property (nonatomic,strong)UILabel *expertType;

//被采纳数，和粉丝数
@property (nonatomic,strong)UILabel *adopCount;
@property (nonatomic,strong)UILabel *fansCount;



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
     self.rigthButton.frame = subRect;
    [self  addSubview:self.rigthButton];
    //5.返回按钮
    UIButton *backbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:[UIImage imageNamed:@"home_expert_detail_back_btn"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton = backbutton;
    self.backButton.frame = CGRectMake(0, kStatusBarHeight, kNavigationBarHeight, kNavigationBarHeight);
    
    [self.imageScrollView addSubview:self.backButton];
    //6.图像视图
    [self initIconView];
    //7.名字和专家类型
    [self initExpertType];
    //8 采纳和粉丝数显示按钮
    UILabel *adopLabel = [self showLabel];
    adopLabel.text = @"被采纳";
    [adopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftButton.mas_top).offset(-17);
        make.right.equalTo(self.leftButton.mas_right);
        make.left.equalTo(self.leftButton.mas_left);
        make.height.equalTo(@18);
    }];
    
    UILabel *fansLabel = [self showLabel];
    fansLabel.text = @"粉丝";
    [fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rigthButton.mas_top).offset(-17);
        make.right.equalTo(self.rigthButton.mas_right);
        make.left.equalTo(self.rigthButton.mas_left);
        make.height.equalTo(@18);
    }];
    //9:采纳数和粉丝数
    self.adopCount =[self countLael];
    self.adopCount.text = @"33";
    
    self.fansCount = [self countLael];
    self.fansCount.text = @"1024";
    
    [self.adopCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(adopLabel.mas_top).offset(-10);
        make.right.equalTo(self.leftButton.mas_right);
        make.left.equalTo(self.leftButton.mas_left);
        make.height.equalTo(@18);

    }];
    
    [self.fansCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fansLabel.mas_top).offset(-10);
        make.right.equalTo(self.rigthButton.mas_right);
        make.left.equalTo(self.rigthButton.mas_left);
        make.height.equalTo(@18);
    }];
    

    
    [self refreshBlurViewForNewImage];
}
#pragma mark---子视图的初始化
//问专家，和添加关注按钮
- (UIButton *)button{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    button.titleLabel.font = kTextFont16;

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}
//头像视图的添加
- (void)initIconView{
    if (self.iconView == nil) {
        self.iconView = [[UIView alloc] init];
        self.iconView.backgroundColor  =[UIColor colorWithHexString:@"#ffffff"];
        
        self.iconView.alpha = 0.6;
        [self addSubview:self.iconView];
        
       self.iconImage = [[UIImageView alloc] init];
        self.iconImage.backgroundColor = [UIColor redColor];
        [self addSubview: self.iconImage];
        
        self.expertTypeImage = [[UIImageView alloc] init];
        [self  addSubview:self.expertTypeImage ];
        
    }
    CGRect subRect ;
    subRect.origin.x = (kScreenSizeWidth-76)/2;
    subRect.origin.y = kStatusBarHeight +20;
    subRect.size.height = subRect.size.width = 76;
    self.iconView.frame = subRect;
    self.iconView.layer.cornerRadius = 76/2;
    self.iconView.layer.masksToBounds = YES;
    
    
    subRect.origin.x = (kScreenSizeWidth-70)/2;
    subRect.origin.y =  kStatusBarHeight +20+3;
    subRect.size.height = subRect.size.width = 70;
    self.iconImage.frame = subRect;
    self.iconImage.layer.cornerRadius = 70/2;
    self.iconImage.layer.masksToBounds = YES;
    
    
    subRect.origin.y = kStatusBarHeight +20 +76-14.5;
    subRect.origin.x = (kScreenSizeWidth-72)/2;
    subRect.size.width = 72;
    subRect.size.height = 29;

    self.expertTypeImage.frame =subRect;
    
    
    
    
}
//头视图的图片
- (void)setHeaderImage:(UIImage *)headerImage
{
    _headerImage = headerImage;
    self.imageView.image = headerImage;
    [self refreshBlurViewForNewImage];
}
//采纳和粉丝的显示label
- (UILabel *)showLabel{

    UILabel * label = [UILabel new];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.alpha = 0.6;
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    return label;
}
- (UILabel *)countLael{
    UILabel *label = [[UILabel alloc] init];
    label.font = kTextFont18;
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    return label;
}

//专家类型
- (void)initExpertType{
    if (self.expertTypeView == nil) {
        self.expertTypeView = [[UIView alloc] init];
        self.expertTypeView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.expertTypeView];
        
        self.expertName = [UILabel new];
        self.expertName.font = kTextFont18;
        self.expertName.textColor = [UIColor colorWithHexString:@"#ffffff"];
        self.expertName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.expertName];
       
        self.expertType = [UILabel new];
        self.expertType.font = kTextFont18;
        self.expertType.textColor = [UIColor colorWithHexString:@"#ffffff"];
        self.expertType.alpha = 0.6;
        self.expertType.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.expertType];
        
    }
    [_expertName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_expertTypeView.mas_top);
        make.bottom.equalTo(_expertTypeView.mas_bottom);
        make.left.equalTo(_expertTypeView.mas_left);
        
    }];
    [_expertType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_expertTypeView.mas_top);
        make.bottom.equalTo(_expertTypeView.mas_bottom);
        make.right.equalTo(_expertTypeView.mas_right);
        
    }];
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
#pragma mark---数据处理
- (void)setModel:(ExpertDetailModel *)model{
    _model = model;
    
    //头像
    NSString *iconimage = _model.usertx;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[APPHelper safeString:iconimage]]];
    NSNumber *grade = _model.grade;
    [_expertTypeImage setImage:[self expertSignImage:grade]];
    
    _expertName.text = _model.xm;
    _expertType.text = _model.zjlxms;
    [self resetExpertInfomationView];
    
    _adopCount.text = _model.hfcns;
    
    NSNumber *fansCount = _model.friends;
    NSInteger count = [fansCount integerValue];
    
    _fansCount.text =[NSString stringWithFormat:@"%ld",count];
    
    
    //[self reloadInputViews];

}
//返回专家的称号标志视图
- (UIImage *)expertSignImage:(NSNumber *)grade{
    
    NSInteger  i = [grade integerValue];
    NSString *imageName;
    if (i==0) {
      imageName = @"zhuanjia";
    }else if(i==1){
       imageName = @"renzhengzhuanjia";
    }else if (i==2){
       imageName = @"fujiaoshou";
    
    }else if(i==3){
       imageName = @"jiaoshou";
    }else if(i==4){
    
       imageName = @"yuanshi";
    }

    UIImage *image = [UIImage imageNamed:imageName];
    
    return image;

}
//重新设置专家信息的视图
- (void)resetExpertInfomationView{
    CGRect subRect;
    NSString *name = _expertName.text;
    NSString *type = _expertType.text;
    CGSize namesize = [name sizeWithFont:kTextFont18 constrainedToSize:CGSizeMake(MAXFLOAT,21)];
    CGSize typesize = [type sizeWithFont:kTextFont18 constrainedToSize:CGSizeMake(MAXFLOAT,21)];
    CGFloat width = namesize.width+15+typesize.width;
    subRect.size.width =width;
    subRect.size.height = namesize.height;
    subRect.origin.y =CGRectGetMaxY(self.iconView.frame)+28;
    subRect.origin.x =(kScreenSizeWidth-width)/2;
    
    self.expertTypeView.frame = subRect;
}

@end

