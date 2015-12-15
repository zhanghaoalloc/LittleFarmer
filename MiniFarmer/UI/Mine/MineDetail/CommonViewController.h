//
//  CommonViewController.h
//  WhatsLive
//
//  Created by 尹新春 on 15/8/7.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPageSize @"10"


@class CommonViewController;
@protocol CommonViewControllerDelegate <NSObject>

@optional

- (void)commonViewController:(CommonViewController *)commonVC model:(id)model;

@end



@interface CommonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) id<CommonViewControllerDelegate>delegate;

@property (nonatomic, assign,readonly) NSInteger pn;
@property (nonatomic, assign) NSInteger ps;
@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) NSString *vcTitle;

- (void)reloadData;

- (void)pullToRefresh;
- (void)loadMoreData;
- (void)cancelCurrentLoadAnimation;

- (void)noMoreData:(BOOL)noMore;

- (NSIndexPath *)indexPathWithCell:(UITableViewCell *)cell;

- (void)setTableBackGroundColor:(UIColor *)color;
@end
