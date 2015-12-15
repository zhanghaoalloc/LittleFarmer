//
//  YHSegmentView.h
//  YHSegmentView
//
//  Created by yahui.zhang on 15/11/18.
//  Copyright © 2015年 yahui.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSegmentView;

@protocol YHSegmentViewDelegate <NSObject>

- (void)segmentView:(YHSegmentView *)segmentView
 didSelectedAtIndex:(NSInteger)index;

@end

@interface YHSegmentItem : NSObject

@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic) UIFont *font;

@end

@interface YHSegmentView : UIView

//items 由 YHSegmentItem 对象组成
- (instancetype)initWithItems:(NSArray *)items;

@property (weak, nonatomic)id <YHSegmentViewDelegate>delegate;

@property (assign, nonatomic)NSInteger selectedIndex;
@property (assign, nonatomic)NSInteger itemsDispace;

@property (assign, nonatomic)NSInteger itemToLeft;
@property (assign, nonatomic)NSInteger directionLineHeigth;
@property (strong, nonatomic)UIColor *textSelectedColor;
@property (strong, nonatomic)UIColor *textNormalColor;
@property (strong, nonatomic)UIColor *directionLineColor;
@property (assign, nonatomic)NSInteger bottomLineHeigth;
@property (strong, nonatomic)UIColor *bottomLineColor;
@property (assign, nonatomic)NSInteger bottomLineToLeft;



- (void)addSegmentItem:(YHSegmentItem *)item;

- (void)insertSegmentItem:(YHSegmentItem *)item
                  atIndex:(NSInteger)index;

- (void)setSelectedIndex:(NSInteger)selectedIndex
                animated:(BOOL)animated;

- (void)setOffsetWithScrollViewWidth:(CGFloat)width
                    scrollViewOffset:(CGFloat)offset;

@end
