//
//  YHSegmentView.m
//  YHSegmentView
//
//  Created by yahui.zhang on 15/11/18.
//  Copyright © 2015年 yahui.zhang. All rights reserved.
//

#import "YHSegmentView.h"
#import "Colours.h"
#import "UIView+FrameCategory.h"

#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )


@implementation YHSegmentItem

@end

@interface YHSegmentView ()

@property (strong, nonatomic)NSMutableArray *items;

@property (strong, nonatomic)NSMutableArray *buttons;

@property (strong, nonatomic)UIView *bottomLineView;

@property (strong, nonatomic)UIImageView *bottomLine;

@end

@implementation YHSegmentView

- (instancetype)initWithItems:(NSArray *)items{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self initialization];
        for (YHSegmentItem *item in items) {
            [self addSegmentItem:item];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        return [self initWithItems:nil];
    }
    return self;
}

- (void)awakeFromNib{
    [self initialization];
}

- (void)initialization{
    
    self.items = [NSMutableArray array];
    self.buttons = [NSMutableArray array];
    
    //最底部一条线
    [self addSubview:self.bottomLine];
    
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.bottomLineView];
    
    
}

-(UIImageView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _bottomLine;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.items.count > 0) {
        //设置底部指示条的frame
        UIButton *btn = [self selectedBtn];
        CGFloat pagerWidth = btn.size.width;
        CGFloat left = btn.origin.x;
        CGFloat height = self.directionLineHeigth;
        CGFloat width = pagerWidth;
        CGFloat top = self.height - height;
        [self.bottomLineView setFrame:CGRectMake(left, top, width, height)];
        
        
        //设置按钮的frame
        CGFloat buttonLeft = self.itemToLeft;
        CGFloat buttonHeight = self.height - height;
        
        for (int i=0; i<self.buttons.count; i++) {
            YHSegmentItem *item = [self.items objectAtIndex:i];
            CGSize size = [self getStringWordWrappingSize:item.title andConstrainToSize:CGSizeMake(CGFLOAT_MAX,buttonHeight) andFont:item.font];
            UIButton *button = [self.buttons objectAtIndex:i];
            [button setFrame:CGRectMake(buttonLeft, 0, size.width, buttonHeight)];
            buttonLeft += size.width + self.itemsDispace;
            if (i == self.selectedIndex) {
                [button setSelected:YES];
            }else{
                [button setSelected:NO];
            }
        }
        
        //设置底部线条
        [self.bottomLine setFrame:CGRectMake(self.bottomLineToLeft, self.height - self.bottomLineHeigth, self.width, self.bottomLineHeigth)];    }
}

- (void)addSegmentItem:(YHSegmentItem *)item{
    if (item) {
        [self.items addObject:item];
        UIButton *button = [self buttonWithItem:item];
        [self addSubview:button];
        [self.buttons addObject:button];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (void)insertSegmentItem:(YHSegmentItem *)item
                  atIndex:(NSInteger)index{
    if (item && index >= 0 && index <self.items.count) {
        [self.items insertObject:item atIndex:index];
        
        UIButton *button = [self buttonWithItem:item];
        [self addSubview:button];
        [self.buttons insertObject:button atIndex:index];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (UIButton *)buttonWithItem:(YHSegmentItem *)item{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:item.title forState:UIControlStateNormal];
    
    [button.titleLabel setFont:item.font];
    
    [button setTitleColor:self.textNormalColor forState:UIControlStateNormal];
    [button setTitleColor:self.textSelectedColor forState:UIControlStateSelected];
//    [button setTitleColor:[UIColor colorFromHexString:@"#333333"] forState:UIControlStateHighlighted];
//    [button setBackgroundColor:[UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1]];
    [button addTarget:self action:@selector(segmentTapAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)segmentTapAction:(UIButton *)btn{
    
    NSInteger index = [self.buttons indexOfObject:btn];
    [self changeToSelectedIndex:index animated:YES];
}

- (void)changeToSelectedIndex:(NSInteger)index animated:(BOOL)animated
{
    [self setSelectedIndex:index animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectedAtIndex:)]) {
        [self.delegate segmentView:self didSelectedAtIndex:index];
    }
 
}

- (void)setOffsetWithScrollViewWidth:(CGFloat)width
                    scrollViewOffset:(CGFloat)offset{
    CGFloat left ;
    
    [self changeToSelectedIndex:(NSInteger)offset / (NSInteger)width animated:YES];
    return;
    
    if ((NSInteger)offset % (NSInteger)width == 0)
    {
        UIButton *btn = [self selectedBtn];
        left = btn.origin.x;
        [self.bottomLineView setWidth:btn.size.width];
    }
    else
    {
        left = (NSInteger)offset % (NSInteger)width;
    }
    NSLog(@"------------- %f",left);
    
    [self.bottomLineView setLeft:left];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
                animated:(BOOL)animated{
    
    UIButton *preBtn = [self.buttons objectAtIndex:self.selectedIndex];
    [preBtn setSelected:NO];
    
    _selectedIndex = selectedIndex;
    
    UIButton *btn = [self.buttons objectAtIndex:self.selectedIndex];
    [btn setSelected:YES];
    
    CGFloat left = btn.origin.x;
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.bottomLineView setLeft:left];
            [self.bottomLineView setWidth:btn.size.width];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [self.bottomLineView setLeft:left];
        [self.bottomLineView setWidth:btn.size.width];

    }
}

-(UIButton *)selectedBtn
{
    return [self.buttons objectAtIndex:self.selectedIndex];
}

- (NSInteger)titleOffset:(BOOL)isLeft shouldHalve:(BOOL)shouldHalve{
    NSInteger offset = 50;
    if (!shouldHalve) {
        return offset;
    }
    if (isLeft) {
        return offset/2;
    }
    return -offset/2;
}


- (CGSize)getStringWordWrappingSize:(NSString *)string andConstrainToSize:(CGSize)size andFont:(UIFont *)font{
    CGSize labelsize;
    if (IOS7_OR_LATER) {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        labelsize = [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
        labelsize.width = ceil(labelsize.width);
        labelsize.height = ceil(labelsize.height);
    }else{
        //        UIFont *font = [UIFont systemFontOfSize:fontSize];
        //        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
    }
    
    return labelsize;
}

- (void)setDirectionLineColor:(UIColor *)directionLineColor
{
    [self.bottomLineView setBackgroundColor:directionLineColor];
}

- (void)setBottomLineColor:(UIColor *)longBottomLineColor
{
    [self.bottomLine setBackgroundColor:longBottomLineColor];
}

@end
