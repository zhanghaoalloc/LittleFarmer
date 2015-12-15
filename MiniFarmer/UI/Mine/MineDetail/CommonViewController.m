//
//  CommonViewController.m
//  WhatsLive
//
//  Created by 尹新春 on 15/8/7.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import "CommonViewController.h"
#import "MJRefresh.h"

@interface CommonViewController ()

@property (nonatomic, strong) UITableView *commonTab;

@property (nonatomic, assign) NSInteger pn;


@end

@implementation CommonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTableView];
//    //添加tableview
////    self.ps = 10;
    [self updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
}



-(void)updateViewConstraints{
    [self.commonTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)reloadData
{
    [self.commonTab reloadData];
}

#pragma mark - addSubviews
- (void)addTableView
{
    self.commonTab = [[UITableView alloc] initWithFrame:CGRectZero];
    self.commonTab.delegate = self;
    self.commonTab.dataSource = self;
    self.commonTab.scrollsToTop = YES;
    self.commonTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.commonTab];
    
    MJRefreshNormalHeader *mjHeader= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLOG(@"home refresh!");
        [self pullToRefresh];
    }];
    self.commonTab.header = mjHeader;
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    [footer.stateLabel setHidden:YES];
    
    self.commonTab.footer = footer;
}

- (void)loadMoreData
{
    
}

- (void)pullToRefresh
{
    
}

- (void)setTableBackGroundColor:(UIColor *)color
{
    [self.commonTab setBackgroundColor:color];
}

- (void)noMoreData:(BOOL)noMore
{
    if (noMore)
    {
        [self.commonTab.footer setState:MJRefreshStateNoMoreData];
    }
    switch (self.commonTab.footer.state) {
        case MJRefreshStateNoMoreData:
        {
            MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.commonTab.footer;
            [footer.stateLabel setHidden:NO];
            
        }
            break;
            
        default:
        {
            MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.commonTab.footer;
            [footer.stateLabel setHidden:YES];
        }
            break;
    }
}

- (void)cancelCurrentLoadAnimation
{
    [self.commonTab.header endRefreshing];
    [self.commonTab.footer endRefreshing];
}



#pragma mark - tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSIndexPath *)indexPathWithCell:(UITableViewCell *)cell
{
    return  [self.commonTab indexPathForCell:cell];
}

#pragma mark - scrollviewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)setCommonTabIsScrollToTop:(BOOL)isScrollToTop
{
    [self.commonTab setScrollsToTop:isScrollToTop];
}




@end
